import 'package:flutter/material.dart';

TextStyle commonTextStyle() {
  return const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
}

String formatDateTime(DateTime date) {
  return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
}

String formatBytes(int? bytes) {
  if (bytes == null || bytes == 0) {
    return "";
  }
  const suffixes = ["B", "KB", "MB", "GB", "TB"];
  double value = bytes.toDouble();

  var i = 0;
  while (value >= 1024 && i < suffixes.length - 1) {
    value /= 1024;
    i++;
  }
  return "${value.toStringAsFixed(2)} ${suffixes[i]}";
}
