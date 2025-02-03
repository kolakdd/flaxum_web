import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'package:file_picker/file_picker.dart';

import 'package:flaxum_fileshare/models/system_position.dart';
import 'package:flaxum_fileshare/models/object_/object_.dart';

import 'package:flaxum_fileshare/providers/object_provider.dart';
import 'package:flaxum_fileshare/providers/position_provider.dart';

import 'package:flaxum_fileshare/network/objects/create_object.dart';
import 'package:flaxum_fileshare/network/objects/upload_file.dart';

// Класс отображения кнопок для создания папки и для загрузки файла
class FabButtons extends StatelessWidget {
  const FabButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Кнопка создания папки
        FloatingActionButton(
          onPressed: () async {
            if (Provider.of<PositionProvider>(context, listen: false)
                    .data
                    .currentScope !=
                Scope.own) {
              return;
            }
            _showCreateFolderDialog(context);
          },
          child: const Icon(Icons.create_new_folder),
        ),
        const SizedBox(height: 16),
        // Кнопка загрузки файла
        FloatingActionButton(
          onPressed: () async {
            final mainPosition = Provider.of<PositionProvider>(context, listen: false).data;
            if (mainPosition.currentScope !=Scope.own) {
              return;
            }
            _uploadSingleFile(context);
          },
          child: const Icon(Icons.upload),
        ),
      ],
    );
  }
}

// Диалог при нажатии на создание папки
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
                final Object_ createdFolder =
                    await createFolder(context, folderName);
                Provider.of<ObjectProvider>(context, listen: false)
                    .addItem(createdFolder);
              }
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Отмена'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// Загрузка одиночного файла
void _uploadSingleFile(BuildContext context) async {
  var picked = await FilePicker.platform.pickFiles();
  if (picked == null) {
    return null;
  }

  final MainPosition currentPosition =
      Provider.of<PositionProvider>(context, listen: false).data;
  final String? parentId = currentPosition.idStack.lastOrNull;

  String fileName = picked.files.first.name;

  final formData = FormData.fromMap({
    'file': MultipartFile.fromBytes(
      picked.files.first.bytes as List<int>,
      filename: fileName,
    ),
  });

  final Object_ createdFolder = await uploadSingleFile(formData, parentId);
  Provider.of<ObjectProvider>(context, listen: false).addItem(createdFolder);
}
