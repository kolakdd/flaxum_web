import 'package:flaxum_fileshare/models/object_.dart';
import 'package:flutter/foundation.dart';
import '../models/context.dart';

// Контекст нахождения в системе
class ContextProvider extends ChangeNotifier {
  Context _data = Context(null, Scope.own, null);

  Context get data => _data;

  void updateScope(Scope? newScope) {
    _data.current_scope = newScope;
    notifyListeners();
  }

  void updateUxoPointer(Object_ newData) {
    _data.uxo_pointer = newData;
    notifyListeners();
  }
}
