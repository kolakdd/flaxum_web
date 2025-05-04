import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flaxum_fileshare/app/network/users/admin_register_user.dart';
import 'package:flaxum_fileshare/app/utils/string_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget registerNewUserButton(context) {
  return SizedBox(
      width: 256,
      child: Row(children: [
        MaterialButton(
          onPressed: () async => UserScopeFeatures.createNewUser(context),
          child: const Text("Добавить пользователя."),
        )
      ]));
}

/// Активности в скоупе юзеров
class UserScopeFeatures {
  /// Создать нового пользователя
  static void createNewUser(context) async {
    _showRegisterUserDialog(context);
  }
}

enum UserRoles { user, admin }

String enumToString(Enum inp) {
  return inp.name;
}

void _showRegisterUserDialog(BuildContext context) async {
  final TextEditingController userEmailController = TextEditingController();
  UserRoles? role = UserRoles.user;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        // StatefulBuilder
        builder: (context, setState) {
          return AlertDialog(
            actions: <Widget>[
              SizedBox(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Создать пользователя"),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: userEmailController,
                        decoration: const InputDecoration(hintText: "Email"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // ------------- RadioButton -----------
                      Column(
                        children: [
                          ListTile(
                            title: const Text('Пользователь'),
                            leading: Radio<UserRoles>(
                              value: UserRoles.user,
                              groupValue: role,
                              onChanged: (UserRoles? value) {
                                setState(() {
                                  role = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Администратор'),
                            leading: Radio<UserRoles>(
                              value: UserRoles.admin,
                              groupValue: role,
                              onChanged: (UserRoles? value) {
                                setState(() {
                                  role = value;
                                });
                              },
                            ),
                          ),
                        ],
                      )
                      // ----------------------------------
                      ,
                      const Divider(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Material(
                            elevation: 5.0,
                            color: Colors.blue[900],
                            child: MaterialButton(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 5.0, 10.0, 5.0),
                              onPressed: () async {
                                String email = userEmailController.text;
                                if (email.isNotEmpty) {
                                  AdminCreateUserResponse newUser =
                                      await createUser(
                                          context,
                                          AdminCreateUser(
                                              email,
                                              enumToString(role!)
                                                  .toCapitalized));
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(actions: <Widget>[
                                          SizedBox(
                                            width: 400,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                const Text(
                                                    "Временный пароль для нового пользователя"),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  height: 2,
                                                  color: Colors.black,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text("Email: ${newUser.email}"),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                    "Password: ${newUser.password}"),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          style: const TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline),
                                                          text:
                                                              'Нажмите, что бы скопировать',
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () =>
                                                                    Clipboard.setData(ClipboardData(
                                                                            text:
                                                                                "${newUser.email} ${newUser.password}"))
                                                                        .then(
                                                                            (_) {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              const SnackBar(content: Text("Email address copied to clipboard")));
                                                                    })),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                const Divider(
                                                  height: 10,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          )
                                        ]);
                                      });
                                }
                              },
                              child: const Text("Ок",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  )),
                            ),
                          ),
                          Material(
                            elevation: 5.0,
                            color: Colors.blue[900],
                            child: MaterialButton(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 5.0, 10.0, 5.0),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text("Отмена",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))
            ],
          );
        },
      );
    },
  );
}

