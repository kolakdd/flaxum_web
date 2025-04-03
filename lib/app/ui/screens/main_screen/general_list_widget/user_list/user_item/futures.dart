import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flutter/material.dart';

/// Логика нажатий на элементы списка
class ItemMouseClickLogic {
  /// Логика нажатия на элемент списка
  void onTap(context, User user) async {
    UserItemFeatures.getObjectUxoAndUpdateProvider(context, user);
  }

  /// Двойное нажатие на элемент списка
  void onDoubleTap(context, User item) async {}

  /// Логика нажатия на элемент списка правой кнопкой мыши
  /// Появление меню с возможностью:
  ///  - Восстановить из корзины
  ///  - ...
  void onSecondaryTapDown(context, TapDownDetails details, User item) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    List<PopupMenuEntry<int>> menuItems = [];
// ---------------------------------
    if (item.isBlocked) {
      menuItems.add(PopupMenuItem(
          value: 1,
          child: const Text('Разблокировать'),
          onTap: () async => UserItemFeatures.unblock(item)));
    } else {
      menuItems.add(PopupMenuItem(
          value: 1,
          child: const Text('Заблокировать'),
          onTap: () async => UserItemFeatures.markAsBlocked(item)));
    }
// ---------------------------------
    if (item.isDeleted) {
      menuItems.add(PopupMenuItem(
          value: 2,
          child: const Text('Восстановить'),
          onTap: () async => UserItemFeatures.undelete(item)));
    } else {
      menuItems.add(PopupMenuItem(
          value: 2,
          child: const Text('Удалить'),
          onTap: () async => UserItemFeatures.markAsDelete(item)));
    }
// ------------- если позиция в собственном корзине --------------------
    menuItems.add(PopupMenuItem(
        value: 3, child: const Text('Изменить'), onTap: () async => {}));

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
class UserItemFeatures {
  // Обновление detailsBar
  static void getObjectUxoAndUpdateProvider(context, User user) async {
    // todo: добавить изменения в правом details баре
  }

  // Отметить удаленным
  static void markAsDelete(User item) async {
    // ...
  }

  /// Отметить заблокированным
  static void markAsBlocked(User item) async {
    // ...
  }

  /// Разблокировать
  static void unblock(User item) async {
    // ...
  }

  /// Вернуть из удаленных
  static void undelete(User item) async {
    // ...
  }
}
