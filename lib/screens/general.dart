// ignore_for_file: avoid_print
import 'package:flaxum_fileshare/dio_client.dart';
import 'package:flaxum_fileshare/models/object_.dart';
import 'package:flutter/material.dart';
import '../screens/object_list.dart';
import 'general_child/file_control_buttons.dart';
import 'general_child/graph_objects.dart';
import 'package:dio/dio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Future<List<Object_>> getOwnObjects(BuildContext context) async {
  final response = await dio_unauthorized.get('/object/own/list',
      options: Options(contentType: "application/json", headers: {
        "authorization": getTokenFromCookie(),
      }));
  if (response.statusCode == 200) {
    final result = GetOwnObjectsResponse.fromJson(response.data);
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
    futureObjectList = getOwnObjects(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.height / 15,
          centerTitle: true,
          title: const Text('flaxum_fileshare'),
          backgroundColor: const Color.fromARGB(248, 199, 104, 167),
        ),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Expanded(
                child: Row(
                  children: [
                    // список файлов видимой области
                    Expanded(
                      child: FutureBuilder<List<Object_>>(
                        future: futureObjectList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return objectListWidget(context, snapshot.data!);
                          } else if (snapshot.hasError) {
                            return Text('ERROR:  ${snapshot.error}');
                          }

                          // By default, show a loading spinner.
                          return Scaffold(
                              body: Center(
                            child: LoadingAnimationWidget.discreteCircle(
                              color: Colors.green,
                              size: 200,
                            ),
                          ));
                        },
                      ),
                      // child: Text("pricol"),
                      // Container(
                      //     color: const Color.fromARGB(255, 54, 244, 168),
                      //     child: objectListWidget(context)),
                    ),
                    // визуальное файловое пространство
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: const Color.fromARGB(255, 202, 204, 87),
                        child: Stack(
                          children: [
                            for (var object in objects)
                              ObjectGraphStateful(object: object),
                          ],
                        ),
                      ),
                    ),
                    // информация о пользователе и мета данные
                    Expanded(
                      child: Container(
                        color: const Color.fromARGB(255, 86, 77, 206),
                        child: const Stack(
                          children: [
                            Center(
                                child: Text(
                                    "информация о пользователе и мета данные")),
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
                  const Spacer(),
                  Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 231, 80, 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          uploadFileButton(context),
                          createFolderButton(context),
                          cleanTrashButton(context),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ]))
              ])
            ])));
  }
}
