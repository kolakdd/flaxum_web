import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/general_list_widget/user_list/user_item/futures.dart';
import 'package:flutter/material.dart';

import 'package:flaxum_fileshare/app/models/system_position.dart';

import 'package:flaxum_fileshare/app/utils/utils_class.dart';

// Виджет для одного элемента списка
class UserItemWidget extends StatefulWidget {
  final User item;
  final MainPosition mainPosition;

  const UserItemWidget({
    required this.item,
    required this.mainPosition,
    super.key,
  });

  @override
  State<UserItemWidget> createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  bool _isHovered = false;
  Utils utils = Utils();
  ItemMouseClickLogic mouseClickLogic = ItemMouseClickLogic();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: userItem(context, widget.item, widget.mainPosition, _isHovered),
    );
  }

  // Главный виджет пользователя
  Widget userItem(BuildContext context, User item, MainPosition mainPosition,
      bool isHovered) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: GestureDetector(
          // Логика нажатия мышью
          onTap: () async => {}, // mouseClickLogic.onTap(context, item),
          onDoubleTap: () async =>
              {}, // mouseClickLogic.onDoubleTap(context, item),
          onSecondaryTapDown: (details) =>
              {mouseClickLogic.onSecondaryTapDown(context, details, item)}, // (
          // context, details, item, mainPosition),
          //
          child: Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              boxShadow: const [
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
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              // изменение цвета при наведении
              color: isHovered ? Colors.grey[200] : Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //
                const SizedBox(width: 12),
                SizedBox(
                    width: 168,
                    child: Text(
                      item.email,
                      style: utils.styleTextUtil.commonTextStyle(),
                    )),
                //
                const SizedBox(width: 12),
                SizedBox(
                    width: 84,
                    child: Text(
                      item.name1,
                      style: utils.styleTextUtil.commonTextStyle(),
                    )),
                //
                const SizedBox(width: 12),
                SizedBox(
                    width: 84,
                    child: Text(
                      item.name2 != null ? item.name2! : "",
                      style: utils.styleTextUtil.commonTextStyle(),
                    )),
                //
                const SizedBox(width: 12),
                SizedBox(
                    width: 84,
                    child: Text(
                      item.name3 != null ? item.name3! : "",
                      style: utils.styleTextUtil.commonTextStyle(),
                    )),
                //

                const SizedBox(width: 12),
                SizedBox(
                    width: 96,
                    child: Text(
                      item.isBlocked.toString(),
                      style: utils.styleTextUtil.commonTextStyle(),
                    )),
                //
                const SizedBox(width: 12),
                SizedBox(
                  width: 96,
                  child: Text(item.isDeleted.toString(),
                      style: utils.styleTextUtil.commonTextStyle()),
                ),
                // размер хранилища
                SizedBox(
                  width: 84,
                  child: Text(
                      utils.formatDataUtil.fBytes(item.storageSize) == ""
                          ? "0 Байт"
                          : utils.formatDataUtil.fBytes(item.storageSize),
                      style: utils.styleTextUtil.commonTextStyle(),
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 12),
                // дата создания файла
                SizedBox(
                  width: 84,
                  child: Text(utils.formatDataUtil.fDateTime(item.createdAt),
                      style: utils.styleTextUtil.commonTextStyle(),
                      overflow: TextOverflow.ellipsis),
                ),
                const Spacer(flex: 1),

                GestureDetector(
                  onTapDown: (details) => mouseClickLogic.onSecondaryTapDown(
                      context, details, item),
                  child: const Icon(Icons.more_vert),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
