import 'package:flutter/foundation.dart';

import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';
import 'package:flaxum_fileshare/app/models/system_position.dart';

// Разделы нахождения в системе
class PositionProvider extends ChangeNotifier {
  final MainPosition _data = MainPosition(Scope.own, null, null, null);

  MainPosition get data => _data;

  // добавить хлебные крошки в стек
  void pushBread(FlaxumObject newData) {
    _data.idStack.add(newData.id);
    _data.nameStack.add(newData.name);
    notifyListeners();
  }

  // удалить последнюю крошку
  void removeLastBread() {
    _data.idStack.removeLast();
    _data.nameStack.removeLast();
    notifyListeners();
  }

  // обновить нахождение текущего раздела
  void updateScope(Scope? newScope) {
    _data.currentScope = newScope;
    notifyListeners();
  }

  // обновить объект к которому относится указатель UXO
  void updateUxoPointer(FlaxumObject newData) {
    _data.uxoPointer = newData;
    notifyListeners();
  }
}
