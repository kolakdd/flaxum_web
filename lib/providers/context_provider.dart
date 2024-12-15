import 'package:flutter/foundation.dart';
import '../models/context.dart';

class ContextProvider extends ChangeNotifier {
  Context _data = Context(null, Scope.own);

  Context get data => _data;

  void updateData(Context newData) {
    _data = newData;
    notifyListeners();
  }
}
