import 'package:flutter/foundation.dart';

class UserPreferencesProvider extends ChangeNotifier {
  // Simple preference flags
  bool _isDairyFree = false;
  bool _isVegetarian = false;
  bool _isGlutenFree = false;

  // Getters to read state
  bool get isDairyFree => _isDairyFree;
  bool get isVegetarian => _isVegetarian;
  bool get isGlutenFree => _isGlutenFree;

  // Toggle methods
  void toggleDairyFree() {
    _isDairyFree = !_isDairyFree;
    notifyListeners();
  }

  void toggleVegetarian() {
    _isVegetarian = !_isVegetarian;
    notifyListeners();
  }

  void toggleGlutenFree() {
    _isGlutenFree = !_isGlutenFree;
    notifyListeners();
  }
}