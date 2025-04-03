// Api текущего скоупа объектов
import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';
import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flutter/material.dart';

class ObjectProvider extends ChangeNotifier {
  List<FlaxumObject> _data = [];
  List<User> _dataUsers = [];

  List<FlaxumObject> get data => _data;
  List<User> get dataUsers => _dataUsers;

  int length() {
    return _data.length;
  }

  void addItem(FlaxumObject newItem) {
    _data.add(newItem);
    notifyListeners();
  }

  void removeItem(String itemId) {
    _data.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void appendData(List<FlaxumObject> newData) {
    _data = _data + newData;
    notifyListeners();
  }

  void appendDataUsers(List<User> newData) {
    _dataUsers = _dataUsers + newData;
    notifyListeners();
  }

  void dropData() {
    _data = [];
    _dataUsers = [];

    notifyListeners();
  }
}
