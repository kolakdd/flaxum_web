import 'package:dio/dio.dart';

import 'package:flaxum_fileshare/app/network/dio_client.dart';

/// Поместить файл в коризу или удалить полностью
/// hardDelete = false - помещение в корзину,
/// hardDelete = true - полное удаление,
Future<bool> removeFile(String itemId, bool hardDelete) async {
  var response = await dioUnauthorized.delete('/object',
      data: {"fileId": itemId, "deleteMark": true, "hardDelete": hardDelete},
      options: Options(contentType: "application/json", headers: {
        "authorization": "Bearer ${getTokenFromCookie()}",
      }));
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

/// Поместить файл в коризу или удалить полностью (в зависимости от флага hard_delete).
Future<bool> restoreFile(String itemId) async {
  var response = await dioUnauthorized.delete('/object',
      data: {"fileId": itemId, "deleteMark": false, "hardDelete": false},
      options: Options(contentType: "application/json", headers: {
        "authorization": "Bearer ${getTokenFromCookie()}",
      }));
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
