import 'dart:html';

import 'package:flutter/material.dart';

import 'package:flaxum_fileshare/app/ui/widgets/icon_widget/flaxum_logo.dart';
import 'package:flaxum_fileshare/app/network/users/login_user.dart';

// Страница авторизации
class LoadAuthScreen extends StatefulWidget {
  const LoadAuthScreen({super.key});

  @override
  State<LoadAuthScreen> createState() => _LoadAuthScreenState();
}

class _LoadAuthScreenState extends State<LoadAuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Лого Flaxum
            mainLogoFlaxum(100, 70),
            // Плашка с полями
            SizedBox(
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
                        const Text(
                          'Вход в систему',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Пароль',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Кнопка логина
                        ElevatedButton(
                          onPressed: () async {
                            final String? authToken = await authorizationUser(
                                _emailController.text,
                                _passwordController.text);
                            if (authToken == null) {
                            } else {
                              document.cookie = "token=$authToken";
                              Navigator.of(context)
                                  .pushReplacementNamed('/objects');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 64, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Войти'),
                        ),

                        //   const SizedBox(height: 20),
                        //   RichText(
                        //     text: TextSpan(
                        //       children: <TextSpan>[
                        //         TextSpan(
                        //             style: const TextStyle(
                        //               fontSize: 14,
                        //               color: Colors.blue,
                        //             ),
                        //             text: ' Регистрация',
                        //             recognizer: TapGestureRecognizer()
                        //               ..onTap = () => Navigator.of(context)
                        //                   .pushReplacementNamed('/register')),
                        //       ],
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
