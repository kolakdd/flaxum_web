import 'package:flaxum_fileshare/screens/register.dart';
import 'package:flutter/material.dart';
import 'screens/auth.dart';
import 'screens/general.dart';
import 'package:provider/provider.dart';
import 'providers/object_provider.dart';
import 'providers/context_provider.dart';
import 'providers/uxo_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ObjectProvider()),
        ChangeNotifierProvider(create: (context) => ContextProvider()),
        ChangeNotifierProvider(create: (context) => UxoProvider()),
      ],
      child: MaterialApp(
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
