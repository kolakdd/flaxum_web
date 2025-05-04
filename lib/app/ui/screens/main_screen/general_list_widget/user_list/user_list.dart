import 'package:dio/dio.dart';
import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flaxum_fileshare/app/network/dio_client.dart';
import 'package:flaxum_fileshare/app/network/objects/fetch.dart';
import 'package:flaxum_fileshare/app/network/users/fetch.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/general_list_widget/user_list/user_item/entity.dart';
import 'package:flaxum_fileshare/app/utils/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/app/models/system_position.dart';

import 'package:flaxum_fileshare/app/providers/object_provider.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';

// Список объектов
class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  void _loadMore() async {
    PositionProvider posProvider =
        Provider.of<PositionProvider>(context, listen: false);

    if (posProvider.offset < posProvider.total &&
        _controller.position.maxScrollExtent == _controller.position.pixels) {
      switch (posProvider.data.currentScope) {
        case Scope.own:
          await getOwnObjects(context, null);
        case Scope.shared:
          await getSharedObjects(context, null);
        case Scope.trash:
          await getTrashObjects(context);
        case Scope.systemFiles:
          await getAdminObjecs(context);
        case Scope.users:
          await getUsersList(context);
        case _:
          // todo;
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<User> objectList = Provider.of<ObjectProvider>(context).dataUsers;
    MainPosition mainPosition = Provider.of<PositionProvider>(context).data;

    return Column(
      children: [
        SizedBox(
            width: 256,
            child: Row(children: [
              MaterialButton(
                onPressed: () async => UserScopeFeatures.createNewUser(context),
                child: const Text("Добавить пользователя."),
              )
            ])),
        itemHeaderUsers(),
        if (objectList.isEmpty)
          const Center(child: Text("Нет пользователей."))
        else
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: objectList.length,
              itemBuilder: (context, idx) {
                var item = objectList[idx];
                return UserItemWidget(
                  item: item,
                  mainPosition: mainPosition,
                );
              },
            ),
          ),
      ],
    );
  }

// ------------- шапка юзер скоупа --------------------
  Widget itemHeaderUsers() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 12),
        SizedBox(width: 168, child: Text("Email")),
        SizedBox(width: 12),
        SizedBox(width: 84, child: Text("Имя")),
        SizedBox(width: 12),
        SizedBox(width: 84, child: Text("Фамилия")),
        SizedBox(width: 12),
        SizedBox(width: 84, child: Text("Отчество")),
        SizedBox(width: 12),
        SizedBox(width: 96, child: Text("Заблокирован")),
        SizedBox(width: 12),
        SizedBox(width: 84, child: Text("Удален")),
        SizedBox(width: 12),
        SizedBox(width: 84, child: Text("Размер хранилища")),
        SizedBox(width: 12),
        SizedBox(width: 84, child: Text("Дата создания")),
      ],
    );
  }
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
                                  await createUser(
                                      context,
                                      AdminCreateUser(email,
                                          enumToString(role!).toCapitalized));
                                }
                                Navigator.of(context).pop();
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

createUser(BuildContext context, AdminCreateUser dto) async {
  final response = await dioUnauthorized.post('/admin/user/register',
      data: {
        "email": dto.email,
        "role": dto.roleType,
      },
      options: Options(contentType: "application/json", headers: {
        "authorization": "Bearer ${getTokenFromCookie()}",
      }));
  if (response.statusCode == 200) {
    final _ = AdminCreateUserResponse.fromJson(response.data);
  } else if (response.statusCode == 401) {
    Navigator.of(context).pushReplacementNamed('/auth');
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to load objects');
  }
}
