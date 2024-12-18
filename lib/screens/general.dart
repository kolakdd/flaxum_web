import 'package:flaxum_fileshare/dio_client.dart';
import 'package:flaxum_fileshare/models/context.dart';
import 'package:flaxum_fileshare/models/object_.dart';
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
      futureObjectList = getOwnObjects(context);
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
          title: Text(Provider.of<ContextProvider>(context, listen: false)
              .data
              .current_scope!
              .toDisplayString(), style: commonTextStyle(),),
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
                        height: 30, width: 500,
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Название",  style: commonTextStyle(), overflow: TextOverflow.ellipsis),
                        const Spacer(flex: 1,),
                        Text("Размер", style: commonTextStyle(), overflow: TextOverflow.ellipsis),
                        const Spacer(flex: 1,),
                        Text("Дата создания",  style: commonTextStyle(), overflow: TextOverflow.ellipsis),
                      ],))
                      ,
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height /1.3,
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
                  // Информация о файле на который нажали
                  Expanded(
                      flex: 1,
                      child: Container(child: () {
                        if (Provider.of<UxoProvider>(context).data.isNotEmpty) {
                          return Column(
                              children: [
                              for (final uxoItem in Provider.of<UxoProvider>(context).data)
                              UxoListStateful(uxoItem: uxoItem,),

                            ],
                          ); 
                        }
                        return const Text('Информация о доступах к файлу');
                      }())),
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
