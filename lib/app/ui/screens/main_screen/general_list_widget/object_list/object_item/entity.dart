import 'package:flutter/material.dart';

import 'package:flaxum_fileshare/app/models/system_position.dart';
import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';

import 'package:flaxum_fileshare/app/ui/widgets/icon_widget/element_icons.dart';
import 'package:flaxum_fileshare/app/utils/utils_class.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/general_list_widget/object_list/object_item/futures.dart';

// Виджет для одного элемента списка
class ObjectItemWidget extends StatefulWidget {
  final FlaxumObject item;
  final MainPosition mainPosition;

  const ObjectItemWidget({
    required this.item,
    required this.mainPosition,
    super.key,
  });

  @override
  State<ObjectItemWidget> createState() => _ObjectItemWidgetState();
}

class _ObjectItemWidgetState extends State<ObjectItemWidget> {
  bool _isHovered = false;
  Utils utils = Utils();
  ItemMouseClickLogic mouseClickLogic = ItemMouseClickLogic();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: objectItem(context, widget.item, widget.mainPosition, _isHovered),
    );
  }

  // Главный виджет объекта
  Widget objectItem(BuildContext context, FlaxumObject item,
      MainPosition mainPosition, bool isHovered) {
    return SizedBox(
        height: 48,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: GestureDetector(
            // Логика нажатия мышью
            onTap: () async => mouseClickLogic.onTap(context, item),
            onDoubleTap: () async => mouseClickLogic.onDoubleTap(context, item),
            onSecondaryTapDown: (details) => mouseClickLogic.onSecondaryTapDown(
                context, details, item, mainPosition),
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
                  // иконка
                  objectIcon(item.type, 32, item),
                  const SizedBox(width: 12),
                  // имя файла
                  SizedBox(
                    width: 128,
                    child: Text(item.name,
                        style: utils.styleTextUtil.commonTextStyle(),
                        overflow: TextOverflow.ellipsis),
                  ),
                  const Spacer(flex: 1),
                  // размер файла
                  SizedBox(
                    width: 128,
                    child: Text(utils.formatDataUtil.fBytes(item.size),
                        // child: Text( ormatBytes(item.size),
                        style: utils.styleTextUtil.commonTextStyle(),
                        overflow: TextOverflow.ellipsis),
                  ),
                  const Spacer(flex: 1),
                  // дата создания файла
                  SizedBox(
                    width: 128,
                    child: Text(utils.formatDataUtil.fDateTime(item.createdAt),
                        style: utils.styleTextUtil.commonTextStyle(),
                        overflow: TextOverflow.ellipsis),
                  ),
                  GestureDetector(
                    onTapDown: (details) => mouseClickLogic.onSecondaryTapDown(
                        context, details, item, mainPosition),
                    child: const Icon(Icons.more_vert),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ));
  }
}
