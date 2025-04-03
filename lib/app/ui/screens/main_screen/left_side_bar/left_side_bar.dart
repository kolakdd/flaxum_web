import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flaxum_fileshare/app/providers/user_provider.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/left_side_bar/admin.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/left_side_bar/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Сайд-бар с разделами (Мои файлы, Коризна, Доступные мне, ...)
class LeftSidebar extends StatelessWidget {
  const LeftSidebar({super.key});
  @override
  Widget build(BuildContext context) {
    UserPublic? user = Provider.of<UserProvider>(context, listen: true).data;
    return Container(
      width: 150,
      color: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _userSection(context),
          if (user != null &&
              (user.roleType == "Admin" || user.roleType == "Superuser"))
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
      Container(height: 24, color: const Color.fromARGB(255, 207, 207, 207)),
      const SizedBox(height: 12),
      const Text(textAlign: TextAlign.center, "Администрирование"),
      const SizedBox(height: 12),
      adminListObjects(context),
      adminListUsers(context),
    ]);
  }
}
