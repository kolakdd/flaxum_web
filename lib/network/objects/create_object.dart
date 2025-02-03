import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flaxum_fileshare/models/object_/object_.dart';
import 'package:flaxum_fileshare/dio_client.dart';
import 'package:flaxum_fileshare/providers/position_provider.dart';
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
