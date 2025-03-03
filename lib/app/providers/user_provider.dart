import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flutter/foundation.dart';

// User class Notifier
class UserProvider extends ChangeNotifier {
  UserPublic? _data;
  UserPublic? get data => _data;

  void updateData(UserPublic userData) {
    _data = userData;
    notifyListeners();
  }
}
