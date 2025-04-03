import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/app/network/dio_client.dart';

import 'package:flaxum_fileshare/app/models/system_position.dart';

import 'package:flaxum_fileshare/app/providers/object_provider.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';

Future<List<User>> _fetchUserList(
    BuildContext context, Scope scope, String? id) async {
  PositionProvider posProvider =
      Provider.of<PositionProvider>(context, listen: false);
  ObjectProvider objProvider =
      Provider.of<ObjectProvider>(context, listen: false);
  NavigatorState navigator = Navigator.of(context);

  if (posProvider.data.currentScope != scope) {
    objProvider.dropData();
  }

  final response = await dioUnauthorized.post(scope.toEndpoint(),
      queryParameters: {
        "offset": posProvider.offset,
        "limit": posProvider.limit
      },
      options: Options(contentType: "application/json", headers: {
        "Cache-Control": "no-cache",
        "authorization": "Bearer ${getTokenFromCookie()}",
      }));

  if (response.statusCode == 200) {
    final result = GetUsersResponse.fromJson(response.data);

    objProvider.appendDataUsers(result.items);

    posProvider.updateScope(
      scope,
      posProvider.offset + posProvider.limit,
      result.total,
    );

    return result.items;
  } else if (response.statusCode == 401) {
    posProvider.dropScope();
    navigator.pushReplacementNamed('/auth');
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to load objects');
  }
}

Future<List<User>> getUsersList(BuildContext context) async {
  return await _fetchUserList(context, Scope.users, null);
}
