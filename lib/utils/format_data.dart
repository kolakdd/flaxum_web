import 'dart:math';

import 'package:flutter/material.dart';

// Общий стиль текста
TextStyle commonTextStyle() {
  return const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
}

// Преобразование даты к дд.мм.гггг
// DateTime(2023, 10, 5) -> 05.10.2023,
// DateTime(1999, 1, 12) -> 12.01.1999
String formatDateTime(DateTime date) {
  return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
}

// Пребразовать байты в оптимальную метрику
String formatBytes(int? bytes) {
  const suffixes = ["B", "KB", "MB", "GB", "TB"];
  if (bytes == null || bytes == 0) {
    return "";
  }
  final i = (log(bytes) / log(1024)).floor();
  final value = bytes / pow(1024, i);
  if (i >= suffixes.length) return "error size";
  return "${value.toStringAsFixed(2)} ${suffixes[i]}";
}
