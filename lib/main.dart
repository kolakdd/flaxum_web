import 'dart:html';

import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flaxum_fileshare/app/app.dart';

void main() async {
  // для отключения контекстных меню в браузере по умолчанию (правая кнопка мыши)
  window.document.onContextMenu.listen((evt) => evt.preventDefault());
  // env
  await dotenv.load(fileName: ".env");
  // mainApp
  runApp(const MyApp());
}
