import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flaxum_fileshare/app/models/object_/object_.dart';
import 'package:flaxum_fileshare/app/api/dio_client.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';
import 'package:dio/dio.dart';

// Создать папку в позиции провайдера
Future<Object_> createFolder(BuildContext context, String name) async {
  final currentPosition =
      Provider.of<PositionProvider>(context, listen: false).data;
  final parentId = currentPosition.idStack.lastOrNull;
  final response = await dioUnauthorized.post('/folder',
      data: {"name": name, "parent_id": parentId},
      options: Options(contentType: "application/json", headers: {
        "authorization": getTokenFromCookie(),
      }));

  if (response.statusCode == 201) {
    final result = CreateFolderResponse.fromJson(response.data);
    return result.data;
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to load objects');
  }
}

// Создать папку в позиции провайдера
Future<Object_> uploadSingleFile(FormData formData, String? parentId) async {
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
    return result.data;
  } else if (response.statusCode == 401) {
    // Navigator.of(context).pushReplacementNamed('/auth');
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to load objects');
  }
}
