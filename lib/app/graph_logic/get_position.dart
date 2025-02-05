import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flaxum_fileshare/app/graph_logic/geometry.dart';

/// Функция для случайного расположения точек на окружности
Offset pointOnCircle(Circle circle) {
  final angle = Random().nextDouble() * 20;
  final k = Random().nextDouble() + 1.5;

  final x = circle.x + circle.r / k * cos(angle);
  final y = circle.y + circle.r / k * sin(angle);
  return Offset(x, y);
}

// Сгенерировать точку в ряду, с определенным индексом
Offset generatePoint(int index) {
  const int maxInRow = 5;
  final row = index ~/ maxInRow;
  return Offset((index - maxInRow * row) * 180, row * 180);
}
