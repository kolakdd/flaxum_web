import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';
import 'package:flaxum_fileshare/app/network/dio_client.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';
import 'package:dio/dio.dart';

// Создать папку в позиции провайдера
Future<FlaxumObject> createFolder(BuildContext context, String name) async {
  final currentPosition =
      Provider.of<PositionProvider>(context, listen: false).data;
  final parentId = currentPosition.idStack.lastOrNull;
  final response = await dioUnauthorized.post('/folder',
      data: {"name": name, "parentId": parentId},
      options: Options(contentType: "application/json", headers: {
        "authorization": "Bearer ${getTokenFromCookie()}",
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
Future<FlaxumObject> uploadSingleFile(
    FormData formData, String? parentId) async {
  final response = await dioUnauthorized.post(
    '/upload',
    data: formData,
    queryParameters: {"parentId": parentId},
    options: Options(
      headers: {
        "authorization": "Bearer ${getTokenFromCookie()}",
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
