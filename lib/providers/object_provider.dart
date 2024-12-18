import 'package:flutter/foundation.dart';
import '../models/object_.dart';

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

  void remodeItem(String itemId) {
    _data.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void updateData(List<Object_> newData) {
    _data = newData;
    notifyListeners();
  }
}
