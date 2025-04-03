import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/app/network/dio_client.dart';

import 'package:flaxum_fileshare/app/models/system_position.dart';
import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';

import 'package:flaxum_fileshare/app/providers/object_provider.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';

Future<List<FlaxumObject>> _fetchObjects(
    BuildContext context, Scope scope, String? id) async {
  PositionProvider posProvider =
      Provider.of<PositionProvider>(context, listen: false);
  ObjectProvider objProvider =
      Provider.of<ObjectProvider>(context, listen: false);
  NavigatorState navigator = Navigator.of(context);

  if (posProvider.data.currentScope != scope ||
      (id == null && posProvider.data.uxoPointer != null) ||
      (id != null && posProvider.data.uxoPointer == null)) {
    objProvider.dropData();
  }

  final response = await dioUnauthorized.post(scope.toEndpoint(),
      queryParameters: {
        "offset": posProvider.offset,
        "limit": posProvider.limit
      },
      data: {"parentId": id},
      options: Options(contentType: "application/json", headers: {
        "Cache-Control": "no-cache",
        "authorization": "Bearer ${getTokenFromCookie()}",
      }));

  if (response.statusCode == 200) {
    final result = GetOwnObjectsResponse.fromJson(response.data);
    objProvider.appendData(result.items);
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

Future<List<FlaxumObject>> getOwnObjects(
    BuildContext context, String? id) async {
  return await _fetchObjects(context, Scope.own, id);
}

Future<List<FlaxumObject>> getTrashObjects(BuildContext context) async {
  return await _fetchObjects(context, Scope.trash, null);
}

Future<List<FlaxumObject>> getSharedObjects(
    BuildContext context, String? id) async {
  return await _fetchObjects(context, Scope.shared, id);
}

Future<List<FlaxumObject>> getAdminObjecs(BuildContext context) async {
  return await _fetchObjects(context, Scope.systemFiles, null);
}
