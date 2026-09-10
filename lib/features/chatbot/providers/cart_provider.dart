import 'package:flutter/foundation.dart';
import '../models/restaurant_model.dart';

class CartProvider with ChangeNotifier {
  // Map item ID to a map containing the item object and its quantity
  final Map<String, _CartEntry> _cartItems = {};

  // Returns list of unique MenuItems in cart
  List<MenuItem> get items =>
      _cartItems.values.map((entry) => entry.item).toList();

  // Returns total count of all individual items (e.g., 2 burgers + 1 pizza = 3)
  int get itemCount =>
      _cartItems.values.fold(0, (sum, entry) => sum + entry.quantity);

  // Calculates grand total price based on quantities
  double get totalPrice => _cartItems.values
      .fold(0.0, (sum, entry) => sum + (entry.item.price * entry.quantity));

  // Check if item exists in cart
  bool isItemInCart(String itemId) {
    return _cartItems.containsKey(itemId);
  }

  // Get specific quantity for quantity selector UI
  int getQuantity(String itemId) {
    return _cartItems[itemId]?.quantity ?? 0;
  }

  // Add item or increment quantity
  void addItem(MenuItem item) {
    if (_cartItems.containsKey(item.id)) {
      _cartItems[item.id]!.quantity += 1;
    } else {
      _cartItems[item.id] = _CartEntry(item: item, quantity: 1);
    }
    notifyListeners();
  }

  // Decrement quantity or remove completely if quantity hits 0
  void removeItem(String itemId) {
    if (_cartItems.containsKey(itemId)) {
      if (_cartItems[itemId]!.quantity > 1) {
        _cartItems[itemId]!.quantity -= 1;
      } else {
        _cartItems.remove(itemId);
      }
      notifyListeners();
    }
  }

  // Clear everything
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

class _CartEntry {
  final MenuItem item;
  int quantity;

  _CartEntry({required this.item, required this.quantity});
}