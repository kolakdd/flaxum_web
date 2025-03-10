import 'package:flutter/foundation.dart';

import 'package:flaxum_fileshare/app/models/uxo/uxo.dart';

// UserXObject class Notifier
class UxoProvider extends ChangeNotifier {
  List<UxoItem> _data = [];
  List<UxoItem> get data => _data;

  int length() {
    return _data.length;
  }

  void dropData(){
    _data = [];
    notifyListeners();
  }

  void updateData(List<UxoItem> newData) {
    _data = newData;
    notifyListeners();
  }

  void addItem(UxoItem newItem) {
    _data.add(newItem);
    notifyListeners();
  }
}
