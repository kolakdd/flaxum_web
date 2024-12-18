import 'package:dio/dio.dart';
import 'package:flaxum_fileshare/dio_client.dart';
import 'package:flaxum_fileshare/models/context.dart';
import 'package:flaxum_fileshare/models/object_.dart';
import 'package:flaxum_fileshare/models/uxo.dart';
import 'package:flaxum_fileshare/screens/general_child/format_data.dart';
import 'package:flutter/material.dart';
import 'general_child/object_list.dart';
import 'general_child/file_control_buttons.dart';
import 'general_child/graph_objects.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../providers/object_provider.dart';
import '../providers/uxo_provider.dart';
import 'general_child/uxo_list.dart';
import '../providers/context_provider.dart';
import '../network/object_list.dart';
import 'auth.dart';
import 'dart:html';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  late Future<List<Object_>> futureObjectList;

  @override
  void initState() {
    super.initState();
    final cookie = getTokenFromCookie();
    if (cookie != null) {
      futureObjectList = getOwnObjects(context, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cookie = getTokenFromCookie();
    if (cookie != null) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.height / 15,
          title: Row(
            children: [
              Text(
                Provider.of<ContextProvider>(context, listen: false)
                    .data
                    .current_scope!
                    .toDisplayString(),
                style: commonTextStyle(),
              ),
              const SizedBox(width: 20),
              if (Provider.of<ContextProvider>(context, listen: false)
                  .data
                  .idStack
                  .isNotEmpty)
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255)),
                    child: const Text(
                      'назад',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    onPressed: () async {
                      switch (
                          Provider.of<ContextProvider>(context, listen: false)
                              .data
                              .current_scope!) {
                        case Scope.own:
                          {
                            Provider.of<ContextProvider>(context, listen: false)
                                .data
                                .idStack
                                .removeLast();
                            Provider.of<ContextProvider>(context, listen: false)
                                .data
                                .nameStack
                                .removeLast();
                            await getOwnObjects(
                                context,
                                Provider.of<ContextProvider>(context,
                                        listen: false)
                                    .data
                                    .idStack
                                    .lastOrNull);
                          }
                        case Scope.shared:
                          {
                            Provider.of<ContextProvider>(context, listen: false)
                                .data
                                .idStack
                                .removeLast();
                            Provider.of<ContextProvider>(context, listen: false)
                                .data
                                .nameStack
                                .removeLast();
                            await getSharedObjects(
                                context,
                                Provider.of<ContextProvider>(context,
                                        listen: false)
                                    .data
                                    .idStack
                                    .lastOrNull);
                          }
                        case _:
                          break;
                      }
                    }),
              const SizedBox(width: 20),
              Text(
                Provider.of<ContextProvider>(context, listen: false)
                    .data
                    .nameStack
                    .join("/"),
                style: commonTextStyle(),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.login),
              tooltip: 'Unlogin',
              onPressed: () {
                document.cookie = "";
                Navigator.of(context).pushReplacementNamed('/auth');
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const TopButtonBar(),
            Expanded(
              child: Row(
                children: [
                  // список файлов видимой области
                  Column(
                    children: [
                      SizedBox(
                          height: 30,
                          width: 600,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Название",
                                  style: commonTextStyle(),
                                  overflow: TextOverflow.ellipsis),
                              const Spacer(
                                flex: 1,
                              ),
                              Text("Размер",
                                  style: commonTextStyle(),
                                  overflow: TextOverflow.ellipsis),
                              const Spacer(
                                flex: 1,
                              ),
                              Text("Дата создания",
                                  style: commonTextStyle(),
                                  overflow: TextOverflow.ellipsis),
                            ],
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height / 1.3,
                          child: FutureBuilder<List<Object_>>(
                            future: futureObjectList,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ObjectListWidget();
                              } else if (snapshot.hasError) {
                                return Text('ERROR:  ${snapshot.error}');
                              }
                              return Center(
                                child: LoadingAnimationWidget.discreteCircle(
                                  color: Colors.green,
                                  size: 200,
                                ),
                              );
                            },
                          ))
                    ],
                  ),
                  // визуальное файловое пространство
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        for (final (index, object)
                            in Provider.of<ObjectProvider>(context)
                                .data
                                .indexed)
                          ObjectGraphStateful(object: object, index: index),
                      ],
                    ),
                  ),
                  // Информация о доступе к файлу на который нажали
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Доступно для:",
                                  style: commonTextStyle(),
                                  overflow: TextOverflow.ellipsis),
                              const Spacer(
                                flex: 1,
                              ),
                              Text("Уровни доступа",
                                  style: commonTextStyle(),
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          const SizedBox(height: 24),
                          if (Provider.of<ContextProvider>(context,
                                      listen: false)
                                  .data
                                  .uxo_pointer !=
                              null && Provider.of<ContextProvider>(context,
                                      listen: false)
                                  .data.current_scope == Scope.own )
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 255, 255)),
                                child: const Text(
                                  'Поделиться',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                onPressed: () async {
                                  if (Provider.of<ContextProvider>(context,
                                              listen: false)
                                          .data
                                          .current_scope !=
                                      Scope.own) {
                                    return;
                                  }
                                  _showAddAccessDialog(context);
                                }),
                          const SizedBox(height: 24),
                          Expanded(child: () {
                            if (Provider.of<UxoProvider>(context)
                                .data
                                .isNotEmpty) {
                              return UxoListStateful(
                                uxoItems:
                                    Provider.of<UxoProvider>(context).data,
                              );
                            }
                            return const Text(
                              'Информация о доступах к файлу',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            );
                          }())
                        ],
                      )),
                ],
              ),
            ),
            BottomButtonBar(context), // Нижняя панель с кнопками
          ],
        ),
      );
    } else {
      return const LoadAuthScreen();
    }
  }
}

class TopButtonBar extends StatelessWidget {
  const TopButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 231, 80, 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: myFiles(context)),
          Expanded(child: trashFiles(context)),
          Expanded(child: sharedFiles(context)),
        ],
      ),
    );
  }
}

class BottomButtonBar extends StatelessWidget {
  final BuildContext context;

  const BottomButtonBar(this.context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 231, 80, 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: uploadFileButton(context)),
          Expanded(child: createFolderButton(context)),
        ],
      ),
    );
  }
}

void _showAddAccessDialog(BuildContext context) async {
  final TextEditingController recipientEmailController =
      TextEditingController();
  bool canRead = true;
  bool canEdit = true;
  bool canDelete = true;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        width: 500,
        height: 500,
        child: AlertDialog(
          title: const Text('Введите логин получателя'),
          content: TextField(
            controller: recipientEmailController,
            decoration: const InputDecoration(hintText: "Логин получателя"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                String recipientEmail = recipientEmailController.text;
                if (recipientEmail.isNotEmpty) {
                  await addAccess(
                      context,
                      Provider.of<ContextProvider>(context, listen: false)
                          .data
                          .uxo_pointer!,
                      CreateUxoDto(
                          canRead, canEdit, canDelete, recipientEmail));
                }
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop(); // Закрываем диалог
              },
            ),
          ],
        ),
      );
    },
  );
}

addAccess(BuildContext context, Object_ object, CreateUxoDto dto) async {
  final response = await dioUnauthorized.post('/access/give/${object.id}',
      data: {
        "can_read": dto.canRead,
        "can_edit": dto.canEdit,
        "can_delete": dto.canDelete,
        "recipient_email": dto.recipientEmail
      },
      options: Options(contentType: "application/json", headers: {
        "authorization": getTokenFromCookie(),
      }));
  if (response.statusCode == 200) {
    final result = CreateUxoResponse.fromJson(response.data);
    Provider.of<UxoProvider>(context, listen: false).addItem(result.data);
  } else if (response.statusCode == 401) {
    Navigator.of(context).pushReplacementNamed('/auth');
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to load objects');
  }
}
