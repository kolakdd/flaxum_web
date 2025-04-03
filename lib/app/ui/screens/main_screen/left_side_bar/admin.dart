import 'package:flaxum_fileshare/app/network/users/fetch.dart';
import 'package:flaxum_fileshare/app/providers/uxo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/app/providers/position_provider.dart';
import 'package:flaxum_fileshare/app/network/objects/fetch.dart';

// Управление файлами
Widget adminListObjects(BuildContext context) {
  return ListTile(
    title: const Text('Управление файлами'),
    onTap: () async {
      PositionProvider posProvider =
          Provider.of<PositionProvider>(context, listen: false);
      UxoProvider uxoProvider =
          Provider.of<UxoProvider>(context, listen: false);
      uxoProvider.dropData();
      posProvider.dropScope();
      await getAdminObjecs(context);
    },
  );
}

// Управление пользователями
Widget adminListUsers(BuildContext context) {
  return ListTile(
    title: const Text('Управление пользователями'),
    onTap: () async {
      PositionProvider posProvider =
          Provider.of<PositionProvider>(context, listen: false);
      UxoProvider uxoProvider =
          Provider.of<UxoProvider>(context, listen: false);
      uxoProvider.dropData();
      posProvider.dropScope();

      await getUsersList(context);
    },
  );
}
