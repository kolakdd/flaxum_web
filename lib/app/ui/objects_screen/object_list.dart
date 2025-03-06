import 'package:flaxum_fileshare/app/network/objects/fetch.dart';
import 'package:flaxum_fileshare/app/ui/objects_screen/object_item/entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/app/models/system_position.dart';
import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';

import 'package:flaxum_fileshare/app/providers/object_provider.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';

// Список объектов
class GeneralListWidget extends StatefulWidget {
  const GeneralListWidget({super.key});

  @override
  State<GeneralListWidget> createState() => _GeneralListWidgetState();
}

class _GeneralListWidgetState extends State<GeneralListWidget> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  void _loadMore() async {
    PositionProvider posProvider =
        Provider.of<PositionProvider>(context, listen: false);

    if (
      posProvider.offset < posProvider.total &&
      _controller.position.maxScrollExtent == _controller.position.pixels
      ) {
      switch (posProvider.data.currentScope) {
        case Scope.own:
          await getOwnObjects(context, null);
        case Scope.shared:
          await getSharedObjects(context, null);
        case Scope.trash:
          await getTrashObjects(context);
        case Scope.users:
          // todo;
          break;
        case _:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<FlaxumObject> objectList = Provider.of<ObjectProvider>(context).data;
    MainPosition mainPosition = Provider.of<PositionProvider>(context).data;

    return Column(
      children: [
        // сделать вариативность и для юзеров
        itemHeaderObjects(),
        if (objectList.isEmpty)
          const Center(child: Text("Здесь нет файлов."))
        else
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: objectList.length,
              itemBuilder: (context, idx) {
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

  Widget itemHeaderObjects() {
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

  Widget itemHeaderUsers() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          SizedBox(width: 44),
          Text("Имя"),
        ]),
        Row(
          children: [
            Text("Фамилия"),
            Text("Размер хранилища"),
          ],
        )
      ],
    );
  }
}
