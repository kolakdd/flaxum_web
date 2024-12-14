import 'package:flaxum_fileshare/screens/register.dart';
import 'package:flutter/material.dart';
import 'screens/auth.dart';
import 'screens/general.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

void main() async {
  // await RustLib.init();
  return runApp(MaterialApp(
      title: 'flaxum_fileshare',
      home: const MainApp(),
      initialRoute: "/objects",
      routes: <String, WidgetBuilder>{
        '/objects': (context) => const MainApp(),
        '/auth': (context) => const LoadAuthScreen(),
        '/register': (context) => const RegisterRoute(),
      }));
}
