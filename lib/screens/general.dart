import 'package:flaxum_fileshare/dio_client.dart';
import 'package:flaxum_fileshare/models/object_.dart';
import 'package:flutter/material.dart';
import 'object_list.dart';
import 'general_child/file_control_buttons.dart';
import 'general_child/graph_objects.dart';
import 'package:dio/dio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../providers/object_provider.dart';
import 'auth.dart';

Future<List<Object_>> getOwnObjects(BuildContext context) async {
  final response = await dio_unauthorized.get('/object/own/list',
      options: Options(contentType: "application/json", headers: {
        "authorization": getTokenFromCookie(),
      }));
  if (response.statusCode == 200) {
    final result = GetOwnObjectsResponse.fromJson(response.data);
    Provider.of<ObjectProvider>(context, listen: false).updateData(result.data);
    return result.data;
  } else if (response.statusCode == 401) {
    Navigator.of(context).pushReplacementNamed('/auth');
    throw Exception('Unauthorize');
  } else {
    throw Exception('Failed to load objects');
  }
}

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
      futureObjectList = getOwnObjects(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cookie = getTokenFromCookie();
    if (cookie != null) {
      return Scaffold(
          backgroundColor: const Color.fromARGB(255, 244, 244, 244),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: MediaQuery.of(context).size.height / 15,
            // Текущая позиция
            title: const Text('Мои файлы'),
          ),
          body: Column(children: [
            Expanded(
              child: Row(
                children: [
                  // список файлов видимой области
                  Expanded(
                    flex: 2,
                    child: FutureBuilder<List<Object_>>(
                      future: futureObjectList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return objectListWidget(context, snapshot.data!);
                        } else if (snapshot.hasError) {
                          return Text('ERROR:  ${snapshot.error}');
                        }
                        return Scaffold(
                            body: Center(
                          child: LoadingAnimationWidget.discreteCircle(
                            color: Colors.green,
                            size: 200,
                          ),
                        ));
                      },
                    ),
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
                  // Информация о файле на который навелись
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: const Color.fromARGB(255, 86, 77, 206),
                      child: const Stack(
                        children: [
                          Center(child: Text("Информация об объекте")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(children: [
              Expanded(
                  child: Row(children: [
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 231, 80, 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: uploadFileButton(context)),
                        Expanded(child: createFolderButton(context)),
                      ],
                    ),
                  ),
                ),
              ]))
            ])
          ]));
    } else {
      return LoadAuthScreen();
    }
  }
}
