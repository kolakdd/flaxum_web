// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flaxum_fileshare/models/object_.dart';
import 'package:flaxum_fileshare/dio_client.dart';
import 'package:flaxum_fileshare/providers/object_provider.dart';
import 'package:flaxum_fileshare/providers/context_provider.dart';

import 'package:dio/dio.dart';

createFolder(BuildContext context, String name) async {
  final ctx = Provider.of<ContextProvider>(context, listen: false).data;
  final parent_id = ctx.current_dir == null ? null : ctx.current_dir!.id;

  final response = await dio_unauthorized.post('/folder',
      data: {"name": name, "parent_id": parent_id},
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


Widget uploadFileButton(BuildContext context) {
  return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }
            return null; // Use the component's default.
          },
        ),
      ),
      child: const Text('Загрузить файл'),
      onPressed: () {});
}

Widget createFolderButton(BuildContext context) {
  return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }
            return null; // Use the component's default.
          },
        ),
      ),
      child: const Text('Создать папку'),
      onPressed: () async {
        _showCreateFolderDialog(context);
      });
}

Widget cleanTrashButton(BuildContext context) {
  return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }
            return null; // Use the component's default.
          },
        ),
      ),
      child: const Text('Очистить корзину'),
      onPressed: () {});
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
                if (folderName.isNotEmpty){
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