import 'package:flaxum_fileshare/app/ui/objects_screen/object_item/entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/app/models/system_position.dart';
import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';

import 'package:flaxum_fileshare/app/providers/object_provider.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    List<FlaxumObject> objectList = Provider.of<ObjectProvider>(context).data;
    MainPosition mainPosition = Provider.of<PositionProvider>(context).data;
    return Column(
      children: [
        itemHeader(),
        if (objectList.isEmpty)
          const Center(child: Text("Здесь нет файлов."))
        else
          Expanded(
            child: ListView.builder(
              itemCount: objectList.length,
              itemBuilder: (context, idx) {
                // Элементы списка
                var item = objectList[idx];
                return ObjectItemWidget(
                  item: item,
                  mainPosition: mainPosition,
                );
              },
            ),
          ),
      ],
    );
  }

  Widget itemHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          SizedBox(width: 44),
          Text("Имя файла"),
        ]),
        Row(
          children: [
            Text("Размер файла"),
            Text("Дата создания файла"),
          ],
        )
      ],
    );
  }
}
