import 'package:dio/dio.dart';
import 'dart:html';

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

final dioUnauthorized = Dio(
  BaseOptions(
    baseUrl: 'http://0.0.0.0:3000',
    connectTimeout: const Duration(seconds: 1),
    headers: {
      'Accept': 'application/json',
    },
    validateStatus: (int? status) {
      return status != null;
    },
  ),
);
