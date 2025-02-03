import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'package:universal_html/html.dart';

import 'package:flaxum_fileshare/dio_client.dart';

import 'package:flaxum_fileshare/models/system_position.dart';
import 'package:flaxum_fileshare/models/object_/object_.dart';
import 'package:flaxum_fileshare/models/uxo/uxo.dart';

import 'package:flaxum_fileshare/providers/object_provider.dart';
import 'package:flaxum_fileshare/providers/position_provider.dart';
import 'package:flaxum_fileshare/providers/uxo_provider.dart';

import 'package:flaxum_fileshare/icon_widget/element_icons.dart';
import 'package:flaxum_fileshare/utils/format_data.dart';

// Список объектов
class ObjectListWidget extends StatefulWidget {
  const ObjectListWidget({super.key});

  @override
  State<ObjectListWidget> createState() => _ObjectListWidgetState();
}

class _ObjectListWidgetState extends State<ObjectListWidget> {
  @override
  void initState() {
    super.initState();
    document.onContextMenu.listen((event) => event.preventDefault());
  }

  @override
  Widget build(BuildContext context) {
    List<Object_> objectList = Provider.of<ObjectProvider>(context).data;
    MainPosition ctx = Provider.of<PositionProvider>(context).data;

    return objectList.isEmpty
        ? const Center(child: Text("Здесь нет файлов."))
        : ListView.builder(
            itemCount: objectList.length,
            itemBuilder: (context, idx) {
              var item = objectList[idx];
              return objectItem(item, ctx);
            },
          );
  }

  // Конеретный объект списка
  Widget objectItem(item, ctx) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () async => _onTap(item),
        onSecondaryTapDown: (details) => _onSecondaryTap(details, item, ctx),
        child: Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 2.0,
                spreadRadius: 1.0,
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              objectIcon(item.type, 25, item),
              const Spacer(flex: 1),
              Expanded(
                flex: 4,
                child: Text(item.name,
                    style: commonTextStyle(), overflow: TextOverflow.ellipsis),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 2,
                child: Text(formatBytes(item.size),
                    style: commonTextStyle(), overflow: TextOverflow.ellipsis),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 4,
                child: Text(formatDateTime(item.created_at),
                    style: commonTextStyle(), overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Логика нажатия на элемент списка
  void _onTap(Object_ object) async {
    final response = await dioUnauthorized.get('/access/list/${object.id}',
        options: Options(contentType: "application/json", headers: {
          "authorization": getTokenFromCookie(),
        }));
    if (response.statusCode == 200) {
      final result = GetUxoResponse.fromJson(response.data);
      Provider.of<UxoProvider>(context, listen: false).updateData(result.data);
      Provider.of<PositionProvider>(context, listen: false)
          .updateUxoPointer(object);
    } else if (response.statusCode == 401) {
      Navigator.of(context).pushReplacementNamed('/auth');
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load objects');
    }
  }

  // Логика нажатия на элемент списка
  void _onSecondaryTap(TapDownDetails details, Object_ item, MainPosition mainPosition) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    List<PopupMenuEntry<int>> menuItems = [];

    if (item.type == "File" && mainPosition.currentScope != Scope.trash) {
      menuItems.add(PopupMenuItem(
          value: 1,
          child: const Text('Скачать'),
          onTap: () async {
            var response = await dioUnauthorized.get('/download',
                queryParameters: {'file_id': item.id},
                options: Options(contentType: "application/json", headers: {
                  "authorization": getTokenFromCookie(),
                }));
              
            if (response.statusCode == 200) {
              // todo: добавить проверку хеш-сумм
              // hashsum
              final url = response.data["data"];
              AnchorElement(href: url)
                ..setAttribute('download', '<downloaded_file_name.pdf>')
                ..click();
            }
          }));
    }

    /// soft deleted
    if (mainPosition.currentScope == Scope.own) {
      menuItems.add(PopupMenuItem(
          value: 2,
          child: const Text('Поместить в корзину'),
          onTap: () async {
            var response = await dioUnauthorized.delete('/object',
                data: {
                  "file_id": item.id,
                  "delete_mark": true,
                  "hard_delete": false
                },
                options: Options(contentType: "application/json", headers: {
                  "authorization": getTokenFromCookie(),
                }));
            if (response.statusCode == 200) {
              Provider.of<ObjectProvider>(context, listen: false)
                  .remodeItem(item.id);
            }
          }));
    }

    if (mainPosition.currentScope == Scope.trash) {
      menuItems.add(PopupMenuItem(
          value: 3,
          child: const Text('Удалить полностью'),
          onTap: () async {
            var response = await dioUnauthorized.delete('/object',
                data: {
                  "file_id": item.id,
                  "delete_mark": true,
                  "hard_delete": true
                },
                options: Options(contentType: "application/json", headers: {
                  "authorization": getTokenFromCookie(),
                }));
            if (response.statusCode == 200) {
              Provider.of<ObjectProvider>(context, listen: false)
                  .remodeItem(item.id);
            }
          }));
    }

    if (mainPosition.currentScope == Scope.trash) {
      menuItems.add(PopupMenuItem(
          value: 4,
          child: const Text('Восстановить'),
          onTap: () async {
            var response = await dioUnauthorized.delete('/object',
                data: {
                  "file_id": item.id,
                  "delete_mark": false,
                  "hard_delete": false
                },
                options: Options(contentType: "application/json", headers: {
                  "authorization": getTokenFromCookie(),
                }));
            if (response.statusCode == 200) {
              Provider.of<ObjectProvider>(context, listen: false)
                  .remodeItem(item.id);
            }
          }));
    }

    showMenu<int>(
      context: context,
      items: menuItems,
      position: RelativeRect.fromSize(
        details.globalPosition & const Size(48.0, 48.0),
        overlay.size,
      ),
    ).then((value) {
      switch (value) {
        case 1:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Скачать clicked'),
            behavior: SnackBarBehavior.floating,
          ));
          break;
        case 2:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Удалить clicked'),
            behavior: SnackBarBehavior.floating,
          ));
          break;
        default:
      }
    });
  }
}
