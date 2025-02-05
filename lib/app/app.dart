import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/app/pages/auth.dart';
import 'package:flaxum_fileshare/app/pages/objects.dart';
import 'package:flaxum_fileshare/app/pages/register.dart';

import 'package:flaxum_fileshare/app/providers/object_provider.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';
import 'package:flaxum_fileshare/app/providers/uxo_provider.dart';

import 'package:flaxum_fileshare/app/utils/utils_class.dart';

import 'package:flaxum_fileshare/app/pages/consts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ObjectProvider()),
        ChangeNotifierProvider(create: (context) => PositionProvider()),
        ChangeNotifierProvider(create: (context) => UxoProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          showSemanticsDebugger: false,
          title: 'Flaxum',
          theme: _defaultThemeData(),
          home: const ObjectsPage(),
          initialRoute: objectsPage,
          routes: <String, WidgetBuilder>{
            objectsPage: (context) => const ObjectsPage(),
            authPage: (context) => const AuthPage(),
            registerPage: (context) => const RegisterPage(),
          }),
    );
  }

  ThemeData _defaultThemeData() {
    Utils utils = Utils();

    return ThemeData(
        textTheme: TextTheme(
            displayLarge: utils.styleTextUtil.commonTextStyle(),
            displayMedium: utils.styleTextUtil.commonTextStyle(),
            displaySmall: utils.styleTextUtil.commonTextStyle(),
            headlineLarge: utils.styleTextUtil.commonTextStyle(),
            headlineMedium: utils.styleTextUtil.commonTextStyle(),
            headlineSmall: utils.styleTextUtil.commonTextStyle(),
            titleLarge: utils.styleTextUtil.commonTextStyle(),
            titleMedium: utils.styleTextUtil.commonTextStyle(),
            titleSmall: utils.styleTextUtil.commonTextStyle(),
            bodyLarge: utils.styleTextUtil.commonTextStyle(),
            bodyMedium: utils.styleTextUtil.commonTextStyle(),
            bodySmall: utils.styleTextUtil.commonTextStyle(),
            labelLarge: utils.styleTextUtil.commonTextStyle(),
            labelMedium: utils.styleTextUtil.commonTextStyle(),
            labelSmall: utils.styleTextUtil.commonTextStyle()));
  }
}
