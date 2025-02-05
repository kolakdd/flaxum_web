import 'dart:html';

import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:flaxum_fileshare/app/api/dio_client.dart';

import 'package:flaxum_fileshare/app/models/object_/object_.dart';
import 'package:flaxum_fileshare/app/api/objects/fetch.dart';

import 'package:flaxum_fileshare/app/ui/login_screen/auth.dart';

import 'package:flaxum_fileshare/app/ui/objects_screen/side_bar.dart';
import 'package:flaxum_fileshare/app/ui/objects_screen/fab_files.dart';
import 'package:flaxum_fileshare/app/ui/objects_screen/object_list.dart';
import 'package:flaxum_fileshare/app/ui/objects_screen/file_details.dart';

// Главное приложение
class ObjectsScreen extends StatefulWidget {
  const ObjectsScreen({super.key});

  @override
  State<ObjectsScreen> createState() => _MainApp();
}

class _MainApp extends State<ObjectsScreen> {
  late Future<List<Object_>> futureObjectList;

  final cookie = getTokenFromCookie();
  // текущий файл для отображения деталей файла
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
    if (cookie != null) {
      return Scaffold(
        //
        appBar: AppBar(
          title: const Text('Flaxum-Web'),
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.height / 15,
          actions: [
            // Иконка пользователя
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // todo
              },
            ),
            // Иконка разлогина
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
        //
        body: Row(
          children: [
            // Левая панель
            const Sidebar(),
            // Главный список файлов
            Expanded(
                child: FutureBuilder<List<Object_>>(
              future: futureObjectList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const ObjectListWidget();
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
            )),
            // Если нажал на файл - детали файла
            const FileDetails(),
          ],
        ),
        floatingActionButton: const FabButtons(), // Кнопки действий
      );
    }
    return const LoadAuthScreen();
  }
}

// @override
// Widget build(BuildContext context) {
//   final cookie = getTokenFromCookie();
//   if (cookie != null) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: MediaQuery.of(context).size.height / 15,
//

//  получение текущей позиции в системе и отображение сверху
// ----------------------------------------------------------------------
//         title: Row(
//           children: [
//             Text(
//               Provider.of<ContextProvider>(context, listen: false)
//                   .data
//                   .current_scope!
//                   .toDisplayString(),
//               style: commonTextStyle(),
//             ),
//             const SizedBox(width: 20),
//             if (Provider.of<ContextProvider>(context, listen: false)
//                 .data
//                 .idStack
//                 .isNotEmpty)
//               ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.zero,
//                       ),
//                       backgroundColor:
//                           const Color.fromARGB(255, 255, 255, 255)),
//                   child: const Text(
//                     'назад',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   onPressed: () async {
//                     switch (
//                         Provider.of<ContextProvider>(context, listen: false)
//                             .data
//                             .current_scope!) {
//                       case Scope.own:
//                         {
//                           Provider.of<ContextProvider>(context, listen: false)
//                               .data
//                               .idStack
//                               .removeLast();
//                           Provider.of<ContextProvider>(context, listen: false)
//                               .data
//                               .nameStack
//                               .removeLast();
//                           await getOwnObjects(
//                               context,
//                               Provider.of<ContextProvider>(context,
//                                       listen: false)
//                                   .data
//                                   .idStack
//                                   .lastOrNull);
//                         }
//                       case Scope.shared:
//                         {
//                           Provider.of<ContextProvider>(context, listen: false)
//                               .data
//                               .idStack
//                               .removeLast();
//                           Provider.of<ContextProvider>(context, listen: false)
//                               .data
//                               .nameStack
//                               .removeLast();
//                           await getSharedObjects(
//                               context,
//                               Provider.of<ContextProvider>(context,
//                                       listen: false)
//                                   .data
//                                   .idStack
//                                   .lastOrNull);
//                         }
//                       case _:
//                         break;
//                     }
//                   }),
//             const SizedBox(width: 20),
//             Text(
//               Provider.of<ContextProvider>(context, listen: false)
//                   .data
//                   .nameStack
//                   .join("/"),
//               style: commonTextStyle(),
//             ),
//           ],
//         ),

// --------------------------------------------------------------------
//       body: Column(
//         children: [
//           const TopButtonBar(),
//           Expanded(
//             child: Row(
//               children: [
//                 // список файлов видимой области
//                 Column(
//                   children: [
//                     SizedBox(
//                         height: 30,
//                         width: 600,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("Название",
//                                 style: commonTextStyle(),
//                                 overflow: TextOverflow.ellipsis),
//                             const Spacer(
//                               flex: 1,
//                             ),
//                             Text("Размер",
//                                 style: commonTextStyle(),
//                                 overflow: TextOverflow.ellipsis),
//                             const Spacer(
//                               flex: 1,
//                             ),
//                             Text("Дата создания",
//                                 style: commonTextStyle(),
//                                 overflow: TextOverflow.ellipsis),
//                           ],
//                         )),

// список объектов
// ---------------------------------------------------------------------------
// SizedBox(
//     width: MediaQuery.of(context).size.width / 3,
//     height: MediaQuery.of(context).size.height / 1.3,
//     child: FutureBuilder<List<Object_>>(
//       future: futureObjectList,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return ObjectListWidget();
//         } else if (snapshot.hasError) {
//           return Text('ERROR:  ${snapshot.error}');
//         }
//         return Center(
//           child: LoadingAnimationWidget.discreteCircle(
//             color: Colors.green,
//             size: 200,
//           ),
//         );
//       },
//     ))
//                   ],
//                 ),

// --------------------------------------------------------------
//                 // визуальное файловое пространство
//                 Expanded(
//                   flex: 3,
//                   child: Stack(
//                     children: [
//                       for (final (index, object)
//                           in Provider.of<ObjectProvider>(context)
//                               .data
//                               .indexed)
//                         ObjectGraphStateful(object: object, index: index),
//                     ],
//                   ),
//                 ),

//-------------------------------------------------------------
//                 // Информация о доступе к файлу на который нажали
//                 Expanded(
//                     flex: 2,
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("Доступно для:",
//                                 style: commonTextStyle(),
//                                 overflow: TextOverflow.ellipsis),
//                             const Spacer(
//                               flex: 1,
//                             ),
//                             Text("Уровни доступа",
//                                 style: commonTextStyle(),
//                                 overflow: TextOverflow.ellipsis),
//                           ],
//                         ),
//                         const SizedBox(height: 24),
//                         if (Provider.of<ContextProvider>(context,
//                                     listen: false)
//                                 .data
//                                 .uxo_pointer !=
//                             null && Provider.of<ContextProvider>(context,
//                                     listen: false)
//                                 .data.current_scope == Scope.own )
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   shape: const RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.zero,
//                                   ),
//                                   backgroundColor: const Color.fromARGB(
//                                       255, 255, 255, 255)),
//                               child: const Text(
//                                 'Поделиться',
//                                 style: TextStyle(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black),
//                               ),
//                               onPressed: () async {
//                                 if (Provider.of<ContextProvider>(context,
//                                             listen: false)
//                                         .data
//                                         .current_scope !=
//                                     Scope.own) {
//                                   return;
//                                 }
//                                 _showAddAccessDialog(context);
//                               }),
//                         const SizedBox(height: 24),
//                         Expanded(child: () {
//                           if (Provider.of<UxoProvider>(context)
//                               .data
//                               .isNotEmpty) {
//                             return UxoListStateful(
//                               uxoItems:
//                                   Provider.of<UxoProvider>(context).data,
//                             );
//                           }
//                           return const Text(
//                             'Информация о доступах к файлу',
//                             style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                           );
//                         }())
//                       ],
//                     )),
//               ],
//             ),
//           ),
//           BottomButtonBar(context), // Нижняя панель с кнопками
//         ],
//       ),
//     );
//   } else {
//     return const LoadAuthScreen();
//   }
// }
// ---------------------------------------------------------------------

// void _showAddAccessDialog(BuildContext context) async {
//   final TextEditingController recipientEmailController =
//       TextEditingController();
//   bool canRead = true;
//   bool canEdit = true;
//   bool canDelete = true;

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return SizedBox(
//         width: 500,
//         height: 500,
//         child: AlertDialog(
//           title: const Text('Введите логин получателя'),
//           content: TextField(
//             controller: recipientEmailController,
//             decoration: const InputDecoration(hintText: "Логин получателя"),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () async {
//                 String recipientEmail = recipientEmailController.text;
//                 if (recipientEmail.isNotEmpty) {
//                   await addAccess(
//                       context,
//                       Provider.of<ContextProvider>(context, listen: false)
//                           .data
//                           .uxo_pointer!,
//                       CreateUxoDto(
//                           canRead, canEdit, canDelete, recipientEmail));
//                 }
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Отмена'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Закрываем диалог
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

// addAccess(BuildContext context, Object_ object, CreateUxoDto dto) async {
//   final response = await dioUnauthorized.post('/access/give/${object.id}',
//       data: {
//         "can_read": dto.canRead,
//         "can_edit": dto.canEdit,
//         "can_delete": dto.canDelete,
//         "recipient_email": dto.recipientEmail
//       },
//       options: Options(contentType: "application/json", headers: {
//         "authorization": getTokenFromCookie(),
//       }));
//   if (response.statusCode == 200) {
//     final result = CreateUxoResponse.fromJson(response.data);
//     Provider.of<UxoProvider>(context, listen: false).addItem(result.data);
//   } else if (response.statusCode == 401) {
//     Navigator.of(context).pushReplacementNamed('/auth');
//     throw Exception('Unauthorized');
//   } else {
//     throw Exception('Failed to load objects');
//   }
// }
