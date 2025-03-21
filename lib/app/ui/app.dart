import 'package:flaxum_fileshare/app/network/users/user_me.dart';
import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';

import 'package:flaxum_fileshare/app/providers/user_provider.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/app_bar/main.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/general_list_widget/general_list.dart';
import 'package:flutter/material.dart';

import 'package:flaxum_fileshare/app/network/dio_client.dart';

import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';
import 'package:flaxum_fileshare/app/network/objects/fetch.dart';

import 'package:flaxum_fileshare/app/ui/screens/login_screen/auth.dart';

import 'package:flaxum_fileshare/app/ui/screens/main_screen/fab_files.dart';
import 'package:provider/provider.dart';

// Главное приложение
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  late Future<List<FlaxumObject>> futureObjectList;


  late Future<UserPublic> futureUserData;
  final cookie = getTokenFromCookie();

  @override
  void initState() {
    super.initState();
    if (cookie != null) {
      futureObjectList = getOwnObjects(context, null);


      futureUserData = getUserMe().then((userData) {
        Provider.of<UserProvider>(context, listen: false).updateData(userData);
        return userData;
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cookie == null) return const LoadAuthScreen();
    
    PositionProvider posProvider = Provider.of<PositionProvider>(context, listen: true);
    
    return Scaffold(
      // ---=== App Bar ===---
      appBar: mainAppBar(context),
      // ---=== List Objects ===---
      body:  generalListBuider(posProvider, futureObjectList),
      // ---=== Fab Buttons ===---
      floatingActionButton: const FabButtons(),
    );
  }
}
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
//         "canRead": dto.canRead,
//         "canEdit": dto.canEdit,
//         "canDelete": dto.canDelete,
//         "recipientEmail": dto.recipientEmail
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
