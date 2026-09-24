import 'package:flutter/material.dart';

class UserPreferencesProvider extends ChangeNotifier {
  bool _isVegan = false;
  bool _isGlutenFree = false;
  bool _isDairyFree = false;

  bool get isVegan => _isVegan;
  bool get isGlutenFree => _isGlutenFree;
  bool get isDairyFree => _isDairyFree;

  void toggleVegan() {
    _isVegan = !_isVegan;
    notifyListeners();
  }

  void toggleGlutenFree() {
    _isGlutenFree = !_isGlutenFree;
    notifyListeners();
  }

  void toggleDairyFree() {
    _isDairyFree = !_isDairyFree;
    notifyListeners();
  }
}