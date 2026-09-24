import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  // Default values MUST start empty / false
  bool _hasActiveOrder = false;
  String _activeOrderId = '';
  String _activeOrderStatus = '';

  List<CartItem> get items => List.unmodifiable(_items);
  List<CartItem> get cartItemsList => List.unmodifiable(_items);

  bool get hasActiveOrder => _hasActiveOrder;
  String get activeOrderId => _activeOrderId;

  // Custom status check
  String get activeOrderStatus {
    if (!_hasActiveOrder) return '';
    return _activeOrderStatus.isEmpty
        ? 'Your food is being prepared 🍳'
        : _activeOrderStatus;
  }

  int get totalItemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  int getQuantity(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      return _items[index].quantity;
    }
    return 0;
  }

  void addItem(dynamic itemOrId, [String? name, double? price]) {
    if (itemOrId is CartItem) {
      final existingIndex = _items.indexWhere((item) => item.id == itemOrId.id);
      if (existingIndex >= 0) {
        _items[existingIndex].quantity += itemOrId.quantity;
      } else {
        _items.add(itemOrId);
      }
    } else if (itemOrId is String && name != null && price != null) {
      final existingIndex = _items.indexWhere((item) => item.id == itemOrId);
      if (existingIndex >= 0) {
        _items[existingIndex].quantity += 1;
      } else {
        _items.add(CartItem(id: itemOrId, name: name, price: price));
      }
    } else if (itemOrId != null) {
      try {
        final id = itemOrId.id.toString();
        final itemName = itemOrId.name.toString();
        final itemPrice = (itemOrId.price as num).toDouble();

        final existingIndex = _items.indexWhere((item) => item.id == id);
        if (existingIndex >= 0) {
          _items[existingIndex].quantity += 1;
        } else {
          _items.add(CartItem(id: id, name: itemName, price: itemPrice));
        }
      } catch (_) {}
    }
    notifyListeners();
  }

  void removeItem(String id) {
    final existingIndex = _items.indexWhere((item) => item.id == id);
    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity -= 1;
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void placeOrder() {
    checkout();
  }

  void checkout() {
    if (_items.isNotEmpty) {
      _hasActiveOrder = true;
      _activeOrderId = (1000 + (DateTime.now().millisecondsSinceEpoch % 8999)).toString();
      _activeOrderStatus = 'Your food is being prepared 🍳';
      _items.clear();
      notifyListeners();
    }
  }

  // Force reset active order state completely
  // Inside CartProvider class in lib/features/chatbot/providers/cart_provider.dart

  void resetOrder() {
    _hasActiveOrder = false;
    _activeOrderId = '';
    _activeOrderStatus = '';
    notifyListeners();
  }

  void updateOrderStatus(String status) {
    _activeOrderStatus = status;
    notifyListeners();
  }
}