import 'package:flutter/foundation.dart';
import '../models/uxo.dart';

class UxoProvider extends ChangeNotifier {
  List<UxoItem> _data = [];
  List<UxoItem> get data => _data;

  int length() {
    return _data.length;
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
