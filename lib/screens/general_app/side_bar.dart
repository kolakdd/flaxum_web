import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/providers/position_provider.dart';
import 'package:flaxum_fileshare/network/objects/fetch_objects.dart';

// Сайд-бар с разделами (Мои файлы, Коризна, Доступные мне, ...)
class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          myFiles(context),
          trashFiles(context),
          sharedFiles(context),
        ],
      ),
    );
  }
}

//  ---------------------- разделы ---------------------
// Мои файлы
Widget myFiles(BuildContext context) {
  return ListTile(
    title: const Text('Мои файлы'),
    onTap: () async {
      Provider.of<PositionProvider>(context, listen: false).data.idStack = [];
      Provider.of<PositionProvider>(context, listen: false).data.nameStack = [];
      await getOwnObjects(context, null);
    },
  );
}

// Корзина
Widget trashFiles(BuildContext context) {
  return ListTile(
    title: const Text('Корзина'),
    onTap: () async {
      Provider.of<PositionProvider>(context, listen: false).data.idStack = [];
      Provider.of<PositionProvider>(context, listen: false).data.nameStack = [];
      await getTrashObjects(context);
    },
  );
}

// Доступные мне
Widget sharedFiles(BuildContext context) {
  return ListTile(
    title: const Text('Доступные мне'),
    onTap: () async {
      Provider.of<PositionProvider>(context, listen: false).data.idStack = [];
      Provider.of<PositionProvider>(context, listen: false).data.nameStack = [];
      await getSharedObjects(context, null);
    },
  );
}
