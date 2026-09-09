import 'package:flutter/foundation.dart';
import '../models/restaurant_model.dart';

class CartProvider with ChangeNotifier {
  // Store the actual selected items
  final List<MenuItem> _items = [];

  List<MenuItem> get items => _items;

  int get itemCount => _items.length;

  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.price);

  // Check if a specific item is already added
  bool isItemInCart(String itemId) {
    return _items.any((item) => item.id == itemId);
  }

  // Add an item to the cart
  void addItem(MenuItem item) {
    _items.add(item);
    notifyListeners();
  }

  // Remove a specific item from the cart
  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  // Clear everything
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}