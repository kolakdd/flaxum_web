import 'package:flaxum_fileshare/models/geometry.dart';
import 'dart:math' show Random, sin, cos;
import 'package:flutter/material.dart';

///Функция для равномерного расположения точек на окружности
Offset pointOnCircle(Circle circle) {
  final angle = Random().nextDouble() * 20;
  final k = Random().nextDouble() + 1.5 // MAIN
      ;
  final x = circle.x + circle.r / k * cos(angle);
  final y = circle.y + circle.r / k * sin(angle);
  return Offset(x, y);
}


Offset generatePoint(int pointSize,  int index) {
  const int maxInRow = 10;
  final row = index ~/ maxInRow;
  return Offset((index - 10 * row) * 90, row * 90);
}