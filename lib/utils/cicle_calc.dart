import 'dart:collection';
import 'dart:math' show sin, cos, pi;
import 'package:flaxum_fileshare/models/geometry.dart';


///Функция для равномерного расположения точек на окружности
Queue<Coordinate> pointOnCircleDart(Circle circle, int number)  {
  final circleVec = Queue<Coordinate>();
  for (var i = 0; i < number; i++) {
    final angle = 2.0 * pi * i / number;
    final x = circle.x + circle.r  * cos(angle);
    final y = circle.y + circle.r  * sin(angle);
    circleVec.addFirst(Coordinate(x: x, y: y));
}
return circleVec; 
}