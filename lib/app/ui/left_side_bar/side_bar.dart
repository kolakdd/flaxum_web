import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flaxum_fileshare/app/providers/user_provider.dart';
import 'package:flaxum_fileshare/app/ui/left_side_bar/admin.dart';
import 'package:flaxum_fileshare/app/ui/left_side_bar/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Сайд-бар с разделами (Мои файлы, Коризна, Доступные мне, ...)
class Sidebar extends StatelessWidget {
  const Sidebar({super.key});
  @override
  Widget build(BuildContext context) {
    UserPublic user = Provider.of<UserProvider>(context, listen: true).data!;
    return Container(
      width: 150,
      color: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _userSection(context),
          if (user.roleType == "Admin" || user.roleType == "Superuser")
            _adminSection(context)
        ],
      ),
    );
  }

  Widget _userSection(BuildContext context) {
    return Column(children: [
      myFiles(context),
      trashFiles(context),
      sharedFiles(context),
    ]);
  }

  Widget _adminSection(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 100),
      const Text(textAlign: TextAlign.center, "Администрирование"),
      const SizedBox(height: 12),
      adminListObjects(context),
      adminListUsers(context),
    ]);
  }
}
