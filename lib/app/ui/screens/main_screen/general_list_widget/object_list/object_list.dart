import 'package:flaxum_fileshare/app/network/objects/fetch.dart';
import 'package:flaxum_fileshare/app/network/users/fetch.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/general_list_widget/object_list/object_item/entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/app/models/system_position.dart';
import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';

import 'package:flaxum_fileshare/app/providers/object_provider.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';

// Список объектов
class ObjectList extends StatefulWidget {
  const ObjectList({super.key});

  @override
  State<ObjectList> createState() => _ObjectListState();
}

class _ObjectListState extends State<ObjectList> {
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

    if (posProvider.offset < posProvider.total &&
        _controller.position.maxScrollExtent == _controller.position.pixels) {
      switch (posProvider.data.currentScope) {
        case Scope.own:
          await getOwnObjects(context, null);
        case Scope.shared:
          await getSharedObjects(context, null);
        case Scope.trash:
          await getTrashObjects(context);
        case Scope.systemFiles:
          await getAdminObjecs(context);
        case Scope.users:
          await getUsersList(context);
        case _:
          // todo;
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
        itemHeaderObjects(),
        if (objectList.isEmpty)
          const Center(heightFactor: 20, child: Text("Здесь нет файлов."))
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 44),
        SizedBox(width: 128, child: Text("Имя файла")),
        Spacer(flex: 1),
        SizedBox(width: 44),
        SizedBox(width: 128, child: Text("Размер файла")),
        SizedBox(width: 44),
        Spacer(flex: 1),
        SizedBox(width: 128, child: Text("Дата создания")),
        SizedBox(width: 36),
      ],
    );
  }
}
