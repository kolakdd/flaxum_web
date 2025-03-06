import 'package:flutter/foundation.dart';

import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';
import 'package:flaxum_fileshare/app/models/system_position.dart';

// Разделы нахождения в системе
class PositionProvider extends ChangeNotifier {
  final int _limit = 20;

  MainPosition _data = MainPosition(Scope.own, null, null, null);
  int _offset = 0;
  int _total = 0;

  MainPosition get data => _data;
  int get limit => _limit;
  int get offset => _offset;
  int get total => _total;

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
  void updateScope(Scope scope, int offset, int total) {
    _data.currentScope = scope;
    _offset = offset;
    _total = total;

    notifyListeners();
  }

  void dropScope() {
    _data = MainPosition(null, null, null, null);
    clerPagination();
    notifyListeners();
  }


  void clerPagination() {
    _offset = 0;
    _total = 0;
    notifyListeners();
  }


  // обновить объект к которому относится указатель UXO
  void updateUxoPointer(FlaxumObject newData) {
    _data.uxoPointer = newData;
    notifyListeners();
  }
}
