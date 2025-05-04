
import 'package:dio/dio.dart';
import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flaxum_fileshare/app/network/dio_client.dart';
import 'package:flutter/material.dart';

Future<AdminCreateUserResponse> createUser(
    BuildContext context, AdminCreateUser dto) async {
  final response = await dioUnauthorized.post('/admin/user/register',
      data: {
        "email": dto.email,
        "role": dto.roleType,
      },
      options: Options(contentType: "application/json", headers: {
        "authorization": "Bearer ${getTokenFromCookie()}",
      }));
  if (response.statusCode == 200) {
    final newUserData = AdminCreateUserResponse.fromJson(response.data);
    return newUserData;
  } else if (response.statusCode == 401) {
    Navigator.of(context).pushReplacementNamed('/auth');
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to load objects');
  }
}
