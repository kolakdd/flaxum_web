import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flaxum_fileshare/models/object_.dart';
import 'package:flaxum_fileshare/dio_client.dart';
import 'package:flaxum_fileshare/providers/object_provider.dart';
import 'package:flaxum_fileshare/providers/context_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import '../../network/object_list.dart';

createFolder(BuildContext context, String name) async {
  final ctx = Provider.of<ContextProvider>(context, listen: false).data;
  final parentId = ctx.idStack.lastOrNull;
  final response = await dioUnauthorized.post('/folder',
      data: {"name": name, "parent_id": parentId},
      options: Options(contentType: "application/json", headers: {
        "authorization": getTokenFromCookie(),
      }));
  if (response.statusCode == 201) {
    final result = CreateFolderResponse.fromJson(response.data);
    Provider.of<ObjectProvider>(context, listen: false).addItem(result.data);
  } else if (response.statusCode == 401) {
    Navigator.of(context).pushReplacementNamed('/auth');
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to load objects');
  }
}

Widget createFolderButton(BuildContext context) {
  return SizedBox(
      height: MediaQuery.of(context).size.height / 15,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
          child: const Text(
            'Создать папку',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          onPressed: () async {
            _showCreateFolderDialog(context);
          }));
}

void _showCreateFolderDialog(BuildContext context) async {
  final TextEditingController folderNameController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Введите имя папки'),
        content: TextField(
          controller: folderNameController,
          decoration: const InputDecoration(hintText: "Имя папки"),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              String folderName = folderNameController.text;
              if (folderName.isNotEmpty) {
                await createFolder(context, folderName);
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
      );
    },
  );
}

Widget uploadFileButton(BuildContext context) {
  return SizedBox(
      height: MediaQuery.of(context).size.height / 15,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              backgroundColor: Colors.white),
          child: const Text(
            'Загрузить файл',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          onPressed: () async {
            var picked = await FilePicker.platform.pickFiles();

            if (picked != null) {
              final ctx =
                  Provider.of<ContextProvider>(context, listen: false).data;
              final parentId = ctx.idStack.lastOrNull;

              // Получаем имя файла
              String fileName = picked.files.first.name;

              // Создаем FormData с файлом и его именем
              final formData = FormData.fromMap({
                'file': MultipartFile.fromBytes(
                  picked.files.first.bytes as List<int>,
                  filename: fileName, // Указываем имя файла здесь
                ),
              });

              final response = await dioUnauthorized.post(
                '/upload',
                data: formData,
                queryParameters: {"parent_id": parentId},
                options: Options(
                  headers: {
                    "Authorization": getTokenFromCookie(),
                    "Content-Type": "multipart/form-data",
                  },
                ),
              );
              if (response.statusCode == 200) {
                final result = CreateFolderResponse.fromJson(response.data);
                Provider.of<ObjectProvider>(context, listen: false)
                    .addItem(result.data);
              } else if (response.statusCode == 401) {
                Navigator.of(context).pushReplacementNamed('/auth');
                throw Exception('Unauthorized');
              } else {
                throw Exception('Failed to load objects');
              }
            }
          }));
}

Widget myFiles(BuildContext context) {
  return SizedBox(
      height: MediaQuery.of(context).size.height / 15,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              backgroundColor: Colors.white),
          child: const Text(
            'Мои файлы',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          onPressed: () async {
            await getOwnObjects(context, null);
          }));
}

Widget trashFiles(BuildContext context) {
  return SizedBox(
      height: MediaQuery.of(context).size.height / 15,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              backgroundColor: Colors.white),
          child: const Text(
            'Корзина',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          onPressed: () async {
            await getTrashObjects(context);
          }));
}

Widget sharedFiles(BuildContext context) {
  return SizedBox(
      height: MediaQuery.of(context).size.height / 15,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              backgroundColor: Colors.white),
          child: const Text(
            'Доступные мне',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          onPressed: () async {
            await getSharedObjects(context, null);
          }));
}
