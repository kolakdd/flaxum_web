import 'package:flaxum_fileshare/models/object_.dart';
import 'package:flaxum_fileshare/screens/register.dart';
import 'package:flutter/material.dart';
import 'screens/auth.dart';
import 'screens/general.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'providers/object_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ObjectProvider()),
      ],
      child: MaterialApp(
      title: 'flaxum_fileshare',
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
