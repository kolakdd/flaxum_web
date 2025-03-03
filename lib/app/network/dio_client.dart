import 'dart:html';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:dio/dio.dart';

String? getTokenFromCookie() {
  final cookie = document.cookie!;
  if (cookie.isNotEmpty) {
    final entity = cookie.split("; ").map((item) {
      final split = item.split("=");
      return MapEntry(split[0], split[1]);
    });
    final cookieMap = Map.fromEntries(entity);
    if (cookieMap["token"] != null) {
      return cookieMap["token"];
    }
  }
  return null;
}

//todo: add auth dependency

final dioUnauthorized = Dio(
  BaseOptions(
    baseUrl: dotenv.env['BACKEND_ENDPOINT']!,
    connectTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
    validateStatus: (int? status) {
      return status != null;
    },
  ),
);
