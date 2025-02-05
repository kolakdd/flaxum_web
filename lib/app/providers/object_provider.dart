import 'package:flutter/foundation.dart';

import 'package:flaxum_fileshare/app/models/object_/object_.dart';

// Api текущего скоупа объектов
class ObjectProvider extends ChangeNotifier {
  List<Object_> _data = [];

  List<Object_> get data => _data;

  int length() {
    return _data.length;
  }

  void addItem(Object_ newItem) {
    _data.add(newItem);
    notifyListeners();
  }

  void removeItem(String itemId) {
    _data.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void updateData(List<Object_> newData) {
    _data = newData;
    notifyListeners();
  }
}
