import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flaxum_fileshare/app/providers/user_provider.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/app_bar/about_user.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/app_bar/actions.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/app_bar/bread_crumbs.dart';
import 'package:flaxum_fileshare/app/ui/widgets/icon_widget/flaxum_logo.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

PreferredSizeWidget mainAppBar(BuildContext context) {
  UserPublic? curUser = Provider.of<UserProvider>(context, listen: true).data;
  return AppBar(
    title: Row(
      children: [
        SizedBox(
            width: 150,
            child: Row(children: [
              mainLogoFlaxum(30, 60),
              const SizedBox(width: 12),
              const Text("Flaxum"),
            ])),
        breadCrumbs(context)
      ],
    ),
    automaticallyImplyLeading: false,
    toolbarHeight: MediaQuery.of(context).size.height / 15,
    actions: [
      if (curUser != null) aboutUser(curUser),
      appBarActions(context),
    ],
  );
}
