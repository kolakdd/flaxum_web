import 'package:dio/dio.dart';

import 'package:flaxum_fileshare/app/api/dio_client.dart';

/// Поместить файл в коризу или удалить полностью
/// hardDelete = false - помещение в корзину,
/// hardDelete = true - полное удаление,
Future<bool> removeFile(String itemId, bool hardDelete) async {
  var response = await dioUnauthorized.delete('/object',
      data: {"file_id": itemId, "delete_mark": true, "hard_delete": hardDelete},
      options: Options(contentType: "application/json", headers: {
        "authorization": getTokenFromCookie(),
      }));
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

/// Поместить файл в коризу или удалить полностью (в зависимости от флага hard_delete).
Future<bool> restoreFile(String itemId) async {
  var response = await dioUnauthorized.delete('/object',
      data: {"file_id": itemId, "delete_mark": false, "hard_delete": false},
      options: Options(contentType: "application/json", headers: {
        "authorization": getTokenFromCookie(),
      }));
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
