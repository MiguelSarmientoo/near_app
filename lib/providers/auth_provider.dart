import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _userId;

  String? get userId => _userId;

  void login(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void logout() {
    _userId = null;
    notifyListeners();
  }
}
