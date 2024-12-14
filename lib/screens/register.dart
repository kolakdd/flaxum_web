import 'package:flutter/material.dart';
import 'dart:html';
import '../dio_client.dart' show dio_unauthorized;

class RegisterRoute extends StatelessWidget {
  const RegisterRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final cookie = document.cookie!;

    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 2, 241, 241),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Регистрация'),
        ),
        body: Column(
          children: [
            const Spacer(),
            Form(
                key: _formKey,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Email"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите почту';
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
                                  labelText: "Пароль"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите пароль';
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
                                  final cookie = document.cookie!;
                                  print(cookie);

                                  // final entity = cookie.split("; ").map((item) {
                                  //   final split = item.split("=");
                                  //   return MapEntry(split[0], split[1]);
                                  // });
                                  // final cookieMap = Map.fromEntries(entity);
                                  // print(cookieMap);

                                  var response = await dio_unauthorized
                                      .post('/user/register', data: {
                                    'email': emailController.text,
                                    'password': passwordController.text
                                  });
                                  if (response.statusCode == 201) {
                                    // sleep(Duration(milliseconds: 500));
                                    response = await dio_unauthorized
                                        .post('/user/login', data: {
                                      'email': emailController.text,
                                      'password': passwordController.text
                                    });
                                    if (response.statusCode == 200) {
                                      "access_token=${response.data["token"]}";

                                      print("token=${response.data["token"]}");
                                      document.cookie =
                                          "token=${response.data["token"]}";
                                      print("COOKIE SETTED");
                                      Navigator.of(context)
                                          .pushReplacementNamed('/objects');
                                    }
                                    if (_formKey.currentState!.validate()) {
                                      if (emailController.text.isNotEmpty &&
                                          passwordController.text.isNotEmpty) {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const MainApp()));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Invalid Credentials')),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Please fill input')),
                                      );
                                    }
                                  } else {
                                    print(response.statusCode);
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ),
                          )
                        ]))),
            const Spacer()
          ],
        ));
  }
}
