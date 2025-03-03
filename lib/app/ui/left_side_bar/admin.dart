import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/app/providers/position_provider.dart';
import 'package:flaxum_fileshare/app/network/objects/fetch.dart';

// Управление файлами
Widget adminListObjects(BuildContext context) {
  return ListTile(
    title: const Text('Управление файлами'),
    onTap: () async {
      Provider.of<PositionProvider>(context, listen: false).data.idStack = [];
      Provider.of<PositionProvider>(context, listen: false).data.nameStack = [];
      await getOwnObjects(context, null);
    },
  );
}

// Управление пользователями
Widget adminListUsers(BuildContext context) {
  return ListTile(
    title: const Text('Управление пользователями'),
    onTap: () async {
      Provider.of<PositionProvider>(context, listen: false).data.idStack = [];
      Provider.of<PositionProvider>(context, listen: false).data.nameStack = [];
      await getTrashObjects(context);
    },
  );
}
