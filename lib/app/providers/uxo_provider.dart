import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';
import 'package:flutter/foundation.dart';

import 'package:flaxum_fileshare/app/models/uxo/uxo.dart';

// UserXObject class Notifier
class UxoProvider extends ChangeNotifier {
  FlaxumObject? objectPointer;
  List<UxoItem> _data = [];
  List<UxoItem> get data => _data;

  int length() {
    return _data.length;
  }

  void dropData() {
    _data = [];
    objectPointer = null;
    notifyListeners();
  }

  void updateData(List<UxoItem> newData, FlaxumObject object) {
    objectPointer = object;
    _data = newData;
    notifyListeners();
  }

  void addItem(UxoItem newItem) {
    _data.add(newItem);
    notifyListeners();
  }
}
