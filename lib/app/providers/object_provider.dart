import 'package:flutter/foundation.dart';

import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';

// Api текущего скоупа объектов
class ObjectProvider extends ChangeNotifier {
  List<FlaxumObject> _data = [];

  List<FlaxumObject> get data => _data;

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

  void updateData(List<FlaxumObject> newData) {
    _data = newData;
    notifyListeners();
  }
}
