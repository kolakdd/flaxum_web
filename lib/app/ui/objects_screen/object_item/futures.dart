import 'package:flaxum_fileshare/app/network/objects/fetch.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'package:universal_html/html.dart';

import 'package:flaxum_fileshare/app/network/dio_client.dart';

import 'package:flaxum_fileshare/app/network/objects/trash.dart';

import 'package:flaxum_fileshare/app/models/system_position.dart';
import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';
import 'package:flaxum_fileshare/app/models/uxo/uxo.dart';

import 'package:flaxum_fileshare/app/providers/object_provider.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';
import 'package:flaxum_fileshare/app/providers/uxo_provider.dart';

/// Логика нажатий на элементы списка
class ItemMouseClickLogic {
  /// Логика нажатия на элемент списка
  void onTap(context, FlaxumObject object) async {
    ObjectItemFeatures.getObjectUxoAndUpdateProvider(context, object);
  }

  /// Двойное нажатие на объект списка
  void onDoubleTap(context, FlaxumObject item) async {
    if (item.type == "Dir") {
      ObjectItemFeatures.moveInsideSubdirectory(context, item);
    } else {
      // todo: скачивание файла
    }
  }

  /// Логика нажатия на элемент списка правой кнопкой мыши
  /// Появление меню с возможностью:
  ///  - Скачать
  ///  - Поместить в корзину
  ///  - Удалить
  ///  - Восстановить из корзины
  ///  - ...
  void onSecondaryTapDown(context, TapDownDetails details, FlaxumObject item,
      MainPosition mainPosition) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    List<PopupMenuEntry<int>> menuItems = [];

    if (item.type == "File" && mainPosition.currentScope != Scope.trash) {
      //
      menuItems.add(PopupMenuItem(
          value: 1,
          child: const Text('Скачать'),
          onTap: () async => ObjectItemFeatures.downloadSingleFile(item)));
    }
// ------------- если позиция в собственном скоупе --------------------
    if (mainPosition.currentScope == Scope.own) {
      //
      menuItems.add(PopupMenuItem(
          value: 2,
          child: const Text('Поместить в корзину'),
          onTap: () async => ObjectItemFeatures.moveToTrash(context, item)));
    }
// ------------- если позиция в собственном корзине --------------------
    if (mainPosition.currentScope == Scope.trash) {
      //
      menuItems.add(PopupMenuItem(
          value: 3,
          child: const Text('Удалить полностью'),
          onTap: () async => ObjectItemFeatures.hardDelete(context, item)));
      //
      menuItems.add(PopupMenuItem(
          value: 4,
          child: const Text('Восстановить'),
          onTap: () async =>
              ObjectItemFeatures.restoreFromTrash(context, item)));
    }

    // для отображения меню возле курсора, используется в паре с GestureDetector, который дает details
    showMenu<int>(
      context: context,
      items: menuItems,
      position: RelativeRect.fromSize(
        details.globalPosition & const Size(48.0, 48.0),
        overlay.size,
      ),
    );
  }
}

/// Активности над объектами списка
class ObjectItemFeatures {
  // Получение списка доступа к файлу (UXO) и обновление информации в провайдере
  static void getObjectUxoAndUpdateProvider(
      context, FlaxumObject object) async {
    // todo: вынести в api
    final response = await dioUnauthorized.get('/access/list/${object.id}',
        options: Options(contentType: "application/json", headers: {
          "authorization": "Bearer ${getTokenFromCookie()}",
        }));
    if (response.statusCode == 200) {
      final result = GetUxoResponse.fromJson(response.data);
      Provider.of<UxoProvider>(context, listen: false).updateData(result.items);
      Provider.of<PositionProvider>(context, listen: false)
          .updateUxoPointer(object);
    } else if (response.statusCode == 401) {
      Navigator.of(context).pushReplacementNamed('/auth');
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load objects');
    }
  }

  // Перемещение внутрь подкаталога
  static void moveInsideSubdirectory(context, FlaxumObject item) async {
    final Scope currentScope =
        (Provider.of<PositionProvider>(context, listen: false)
            .data
            .currentScope!);
    switch (currentScope) {
      // перемещение внутри корзины не возможно
      case Scope.trash:
        break;
      // перемещение внутри по собственным файлам
      case Scope.own:
        getOwnObjects(context, item.id);
        Provider.of<PositionProvider>(context, listen: false).pushBread(item);
        break;
      // перемещение внутри по каталогам из "Доступное мне"
      case Scope.shared:
        getSharedObjects(context, item.id);
        Provider.of<PositionProvider>(context, listen: false).pushBread(item);
        break;
    }
  }

  // Скачивание одиночного файла
  static void downloadSingleFile(FlaxumObject item) async {
    var response = await dioUnauthorized.get('/download',
        queryParameters: {'fileId': item.id},
        options: Options(contentType: "application/json", headers: {
          "authorization": "Bearer ${getTokenFromCookie()}",
        }));

    if (response.statusCode == 200) {
      // todo: добавить проверку хеш-сумм
      final url = response.data["url"];
      AnchorElement(href: url)
        ..setAttribute('download', '<downloaded_file_name.pdf>')
        ..click();
    }
  }

  /// Поместить в корзину
  static void moveToTrash(context, FlaxumObject item) async {
    final bool fileDelete = await removeFile(item.id, false);
    if (fileDelete) {
      Provider.of<ObjectProvider>(context, listen: false).removeItem(item.id);
    }
  }

  /// Полное удаление файла
  static void hardDelete(context, FlaxumObject item) async {
    final bool fileDeleted = await removeFile(item.id, true);
    if (fileDeleted) {
      Provider.of<ObjectProvider>(context, listen: false).removeItem(item.id);
    }
  }

  /// Восстановить файл из корзины
  static void restoreFromTrash(context, FlaxumObject item) async {
    final bool fileResored = await restoreFile(item.id);
    if (fileResored) {
      Provider.of<ObjectProvider>(context, listen: false).removeItem(item.id);
    }
  }
}
