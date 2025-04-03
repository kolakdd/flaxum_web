import 'package:flaxum_fileshare/app/network/users/user_me.dart';
import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';

import 'package:flaxum_fileshare/app/providers/user_provider.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/app_bar/main.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/general_list_widget/general_list.dart';
import 'package:flutter/material.dart';

import 'package:flaxum_fileshare/app/network/dio_client.dart';

import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';
import 'package:flaxum_fileshare/app/network/objects/fetch.dart';

import 'package:flaxum_fileshare/app/ui/screens/login_screen/auth.dart';

import 'package:flaxum_fileshare/app/ui/screens/main_screen/fab_files.dart';
import 'package:provider/provider.dart';

// Главное приложение
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  late Future<List<FlaxumObject>> futureObjectList;

  late Future<UserPublic> futureUserData;
  final cookie = getTokenFromCookie();

  @override
  void initState() {
    super.initState();
    if (cookie != null) {
      futureObjectList = getOwnObjects(context, null);

      futureUserData = getUserMe().then((userData) {
        Provider.of<UserProvider>(context, listen: false).updateData(userData);
        return userData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cookie == null) return const LoadAuthScreen();

    PositionProvider posProvider =
        Provider.of<PositionProvider>(context, listen: true);

    return Scaffold(
      appBar: mainAppBar(context),
      body: generalListBuider(posProvider, futureObjectList),
      floatingActionButton: const FabButtons(),
    );
  }
}
