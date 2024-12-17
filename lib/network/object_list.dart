import 'package:flaxum_fileshare/dio_client.dart';
import 'package:flaxum_fileshare/models/context.dart';
import 'package:flaxum_fileshare/models/object_.dart';
import 'package:flutter/material.dart';
import 'object_list.dart';
import '../screens/general_child/file_control_buttons.dart';
import '../screens/general_child/graph_objects.dart';
import 'package:dio/dio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../providers/object_provider.dart';
import '../providers/context_provider.dart';
import '../screens/auth.dart';
import 'dart:html';

Future<List<Object_>> _fetchObjects(
    BuildContext context, String endpoint, Scope scope) async {
  final response = await dio_unauthorized.get(endpoint,
      options: Options(contentType: "application/json", headers: {
        "authorization": getTokenFromCookie(),
      }));

  if (response.statusCode == 200) {
    final result = GetOwnObjectsResponse.fromJson(response.data);
    Provider.of<ObjectProvider>(context, listen: false).updateData(result.data);
    Provider.of<ContextProvider>(context, listen: false).updateScope(scope);

    return result.data;
  } else if (response.statusCode == 401) {
    Provider.of<ContextProvider>(context, listen: false).updateScope(null);
    Navigator.of(context).pushReplacementNamed('/auth');
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to load objects');
  }
}

Future<List<Object_>> getOwnObjects(BuildContext context) async {
  return await _fetchObjects(context, '/object/own/list', Scope.own);
}

Future<List<Object_>> getTrashObjects(BuildContext context) async {
  return await _fetchObjects(context, '/object/trash/list', Scope.trash);
}

Future<List<Object_>> getSharedObjects(BuildContext context) async {
  return await _fetchObjects(context, '/object/shared/list', Scope.shared);
}
