import 'package:dio/dio.dart';

import 'package:flaxum_fileshare/app/network/dio_client.dart';
import 'package:flaxum_fileshare/app/models/user/user.dart';

Future<UserPublic> getUserMe() async {
  var response = await dioUnauthorized.get('/user/me',
      options: Options(contentType: "application/json", headers: {
        "authorization": "Bearer ${getTokenFromCookie()}",
      }));
  if (response.statusCode == 200) {
    final result = UserPublic.fromJson(response.data);
    return result;
  }
  throw Exception('Can\' get user me');
}

// Change user's name1, name2, name2
Future<UserPublic> putUserMe() async {
  var response = await dioUnauthorized.put('/user/me',
      options: Options(contentType: "application/json", headers: {
        "authorization": "Bearer ${getTokenFromCookie()}",
      }),
      data: {
        "name1": "Name1 changed",
        "name2": "Name2 changed",
        "name3": "Name3 changed"
      });
  if (response.statusCode == 200) {
    final result = UserPublic.fromJson(response.data);
    return result;
  }
  throw Exception('Can\' get user me');
}
