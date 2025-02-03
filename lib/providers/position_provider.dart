import 'package:flutter/foundation.dart';

import 'package:flaxum_fileshare/models/object_/object_.dart';
import 'package:flaxum_fileshare/models/system_position.dart';

// Разделы нахождения в системе
class PositionProvider extends ChangeNotifier {
  final MainPosition _data = MainPosition(Scope.own, null, null, null);

  MainPosition get data => _data;

  // добавить хлебные крошки в стек
  void pushBread(Object_ newData) {
    _data.idStack.add(newData.id);
    _data.nameStack.add(newData.name);
    notifyListeners();
  }

  // обновить нахождение текущего раздела
  void updateScope(Scope? newScope) {
    _data.currentScope = newScope;
    notifyListeners();
  }

  // обновить нахождение текущего раздела
  void updateUxoPointer(Object_ newData) {
    _data.uxoPointer = newData;
    notifyListeners();
  }
}
