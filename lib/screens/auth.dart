import 'package:flutter/material.dart';
import 'dart:html';
import '../dio_client.dart' show dio_unauthorized;
import 'package:provider/provider.dart';
import '../providers/object_provider.dart';



class LoadAuthScreen extends StatefulWidget {
  @override
  _LoadAuthScreenState createState() => _LoadAuthScreenState();
}

class _LoadAuthScreenState extends State<LoadAuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ObjectProvider>(context);

        final cookie = document.cookie!;

    if (cookie.isNotEmpty) {
      final entity = cookie.split("; ").map((item) {
        final split = item.split("=");
        return MapEntry(split[0], split[1]);
      });
      final cookieMap = Map.fromEntries(entity);
      if (cookieMap["token"] != null) {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainApp()));
      }
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
                  child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Вход в систему',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Пароль',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                    var response = await dio_unauthorized
                                    .post('/user/login', data: {
                                  'email': _emailController.text,
                                  'password': _passwordController.text
                                });
                                      if (response.statusCode == 200) {
                                  document.cookie =
                                      "token=${response.data["token"]}";
                                  Navigator.of(context)
                                      .pushReplacementNamed('/objects');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Invalid Credentials')),
                                  );
                                }

                      

                      String email = _emailController.text;
                      String password = _passwordController.text;
                      print('Email: $email, Password: $password');
                    },
                    child: Text('Войти'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 64, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
Navigator.of(context)
                                  .pushReplacementNamed('/register');
                    },
                    child: Text('Регистрация'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}