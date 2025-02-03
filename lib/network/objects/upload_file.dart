import 'package:dio/dio.dart';

import 'package:flaxum_fileshare/models/object_/object_.dart';
import 'package:flaxum_fileshare/dio_client.dart';

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
