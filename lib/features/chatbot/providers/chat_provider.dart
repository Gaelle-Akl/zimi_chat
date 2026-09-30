import 'package:flutter/material.dart';
import '../models/chat_message_model.dart';
import 'user_preferences_provider.dart';
import 'cart_provider.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessageModel> _messages = [];

  List<ChatMessageModel> get messages => List.unmodifiable(_messages);

  ChatProvider() {
    _addInitialGreeting();
  }

  void _addInitialGreeting() {
    _messages.add(
      ChatMessageModel(
        text: "Hi! I'm Zimi, your food companion. How can I help you today?",
        isUser: false,
      ),
    );
  }

  void sendMessage(
      String text,
      UserPreferencesProvider prefsProvider,
      CartProvider cartProvider,
      ) {
    final query = text.trim();
    if (query.isEmpty) return;

    _messages.add(ChatMessageModel(text: query, isUser: true));
    notifyListeners();

    final lowerQuery = query.toLowerCase();

    // HELP / SUPPORT
    if (lowerQuery.contains('help')) {
      _addAiReply("I'm here to help! Search for foods like 'burgers', 'pizza', or 'sushi', or track an active order.");
      return;
    }

    // TRACK ORDER
    if (lowerQuery.contains('track') || lowerQuery.contains('order')) {
      if (!cartProvider.hasActiveOrder) {
        _addAiReply("You don't have an active order right now. Add items to your cart and check out first!");
      } else {
        _addAiReply("📦 Order #${cartProvider.activeOrderId} Status:\n\n${cartProvider.activeOrderStatus}");
      }
      return;
    }

    // DEALS & OFFERS
    if (lowerQuery.contains('deal') || lowerQuery.contains('offer') || lowerQuery.contains('popular')) {
      _addAiReply("We have special discounts today! 🏷️ What kind of food are you craving?");
      return;
    }

    // SEARCH & RECOMMENDATIONS
    List<MenuItemModel> searchResults = _searchMenuItems(lowerQuery, prefsProvider);

    if (searchResults.isNotEmpty) {
      _messages.add(
        ChatMessageModel(
          text: "Here are fresh options matching your request:",
          isUser: false,
          menuItems: searchResults,
        ),
      );
      notifyListeners();
      return;
    }

    // FALLBACK
    _addAiReply("I couldn't find exact matches. Try searching for 'Burgers', 'Pizza', or 'Sushi'!");
  }

  void updateFilterResults(UserPreferencesProvider prefs, CartProvider cart) {
    _addAiReply("Preferences updated! Try searching for your favorite dish to view filtered results.");
  }

  List<MenuItemModel> _searchMenuItems(String query, UserPreferencesProvider prefs) {
    final cleanQuery = query.toLowerCase();

    final List<MenuItemModel> allItems = [
      MenuItemModel(
        id: '1',
        name: 'Classic Cheeseburger',
        category: 'burgers',
        price: 12.99,
        description: 'Juicy beef patty, cheddar cheese, fresh lettuce & special sauce.',
        imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
        isVegan: false,
        isGlutenFree: false,
        isDairyFree: false,
      ),
      MenuItemModel(
        id: '2',
        name: 'Vegan Mushroom Burger',
        category: 'burgers',
        price: 13.50,
        description: 'Grilled plant-based patty with savory sautéed mushrooms & avocado spread.',
        imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=400',
        isVegan: true,
        isGlutenFree: true,
        isDairyFree: true,
      ),
      MenuItemModel(
        id: '4',
        name: 'Margherita Woodfired Pizza',
        category: 'pizza',
        price: 14.00,
        description: 'Fresh basil, creamy mozzarella, and slow-cooked tomato sauce.',
        imageUrl: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400',
        isVegan: false,
        isGlutenFree: false,
        isDairyFree: false,
      ),
      MenuItemModel(
        id: '5',
        name: 'Vegan Gluten-Free Garden Pizza',
        category: 'pizza',
        price: 15.50,
        description: 'Gluten-free crust, vegan cheese, bell peppers, olives & mushrooms.',
        imageUrl: 'https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?w=400',
        isVegan: true,
        isGlutenFree: true,
        isDairyFree: true,
      ),
      MenuItemModel(
        id: '7',
        name: 'Fresh Salmon Roll Sushi',
        category: 'sushi',
        price: 15.00,
        description: 'Atlantic salmon, crisp cucumber, and seasoned rice.',
        imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=400',
        isVegan: false,
        isGlutenFree: true,
        isDairyFree: true,
      ),
    ];

    return allItems.where((item) {
      if (prefs.isVegan && !item.isVegan) return false;
      if (prefs.isGlutenFree && !item.isGlutenFree) return false;
      if (prefs.isDairyFree && !item.isDairyFree) return false;

      if (cleanQuery.contains('food')) return true;

      return item.name.toLowerCase().contains(cleanQuery) ||
          item.category.toLowerCase().contains(cleanQuery);
    }).toList();
  }

  void _addAiReply(String text) {
    _messages.add(ChatMessageModel(text: text, isUser: false));
    notifyListeners();
  }

  void clearMessages(CartProvider cartProvider) {
    _messages.clear();
    _addInitialGreeting();
    notifyListeners();
  }
}