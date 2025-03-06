import 'package:flaxum_fileshare/app/providers/object_provider.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart';

Widget appBarActions(context) {
  return Row(
    children: [
      IconButton(
        icon: const Icon(Icons.person),
        onPressed: () {
          // todo
        },
      ),
      IconButton(
        icon: const Icon(Icons.login),
        tooltip: 'Unlogin',
        onPressed: () {
          PositionProvider currentPosition = Provider.of<PositionProvider>(context, listen: false);
          ObjectProvider objProvider = Provider.of<ObjectProvider>(context, listen: false);


          currentPosition.dropScope();
          objProvider.dropData();
          
          document.cookie = "";
          Navigator.of(context).pushReplacementNamed('/auth');
        },
      ),
    ],
  );
}
