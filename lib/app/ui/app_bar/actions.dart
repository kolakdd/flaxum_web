import 'package:flutter/material.dart';
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
          document.cookie = "";
          Navigator.of(context).pushReplacementNamed('/auth');
        },
      ),
    ],
  );
}
