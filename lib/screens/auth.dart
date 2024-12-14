import 'package:flutter/material.dart';
import 'dart:html';
import '../dio_client.dart' show dio_unauthorized;

class LoadAuthScreen extends StatelessWidget {
  const LoadAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
        backgroundColor: const Color.fromARGB(253, 2, 241, 241),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Авторизация'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisSize.spaceEvenly ,
          children: [
            Form(
                key: _formKey,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var response = await dio_unauthorized
                                    .post('/user/login', data: {
                                  'email': emailController.text,
                                  'password': passwordController.text
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
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill input')),
                                );
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/register');
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const RegisterRoute()));
                            },
                            child: const Text('Регистрация'),
                          ),
                        ),
                      )
                    ]))),
          ],
        ));
  }
}
