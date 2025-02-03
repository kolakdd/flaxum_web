import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/screens/login_screen/register.dart';
import 'package:flaxum_fileshare/screens/login_screen/auth.dart';
import 'package:flaxum_fileshare/screens/general_app/app.dart';

import 'package:flaxum_fileshare/providers/object_provider.dart';
import 'package:flaxum_fileshare/providers/position_provider.dart';
import 'package:flaxum_fileshare/providers/uxo_provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

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
          home: const MainApp(),
          initialRoute: "/objects",
          routes: <String, WidgetBuilder>{
            '/objects': (context) => const MainApp(),
            '/auth': (context) => const LoadAuthScreen(),
            '/register': (context) => const RegisterRoute(),
          }),
    );
  }
}
