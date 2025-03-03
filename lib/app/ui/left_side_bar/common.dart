import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/app/providers/position_provider.dart';
import 'package:flaxum_fileshare/app/network/objects/fetch.dart';

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
