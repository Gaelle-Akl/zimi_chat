import 'package:flutter/foundation.dart';
import '../data/mock_restaurants.dart';
import '../models/restaurant_model.dart';
import 'user_preferences_provider.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final List<Restaurant>? recommendedRestaurants;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.recommendedRestaurants,
  });
}

class ChatProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  // Clear messages method placed properly as a class method
  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }

  void sendMessage(String text, UserPreferencesProvider userPrefs) async {
    if (text.trim().isEmpty) return;

    // 1. Add User Message
    _messages.add(ChatMessage(text: text, isUser: true));
    _isLoading = true;
    notifyListeners();

    // Simulate brief bot processing delay
    await Future.delayed(const Duration(milliseconds: 600));

    // 2. Identify Category from Input
    final lowerText = text.toLowerCase();
    String detectedCategory = '';

    if (lowerText.contains('pizza')) {
      detectedCategory = 'pizza';
    } else if (lowerText.contains('burger')) {
      detectedCategory = 'burger';
    } else if (lowerText.contains('ice cream') ||
        lowerText.contains('icecream') ||
        lowerText.contains('dessert')) {
      detectedCategory = 'ice cream';
    }

    // 3. Process Response
    if (detectedCategory.isNotEmpty) {
      // Filter restaurants matching category and apply active preferences
      final filteredList = mockRestaurants.where((rest) {
        if (rest.category != detectedCategory) return false;

        // Ensure restaurant has at least 1 menu item matching active filters
        final hasMatchingItems = rest.menu.any((item) {
          if (userPrefs.isVegetarian && !item.isVegan) return false;
          if (userPrefs.isDairyFree && !item.isDairyFree) return false;
          return true;
        });

        return hasMatchingItems;
      }).toList();

      if (filteredList.isNotEmpty) {
        String filterNotice = '';
        if (userPrefs.isVegetarian) filterNotice += ' (Vegan filtered)';
        if (userPrefs.isDairyFree) filterNotice += ' (Dairy-Free filtered)';

        _messages.add(
          ChatMessage(
            text:
            'Here are top Lebanese places for $detectedCategory$filterNotice:',
            isUser: false,
            recommendedRestaurants: filteredList,
          ),
        );
      } else {
        _messages.add(
          ChatMessage(
            text:
            'Sorry, I couldn\'t find any $detectedCategory places matching your active dietary preferences!',
            isUser: false,
          ),
        );
      }
    } else {
      _messages.add(
        ChatMessage(
          text:
          'I can help you find Lebanese spots! Try asking for "pizza", "burgers", or "ice cream".',
          isUser: false,
        ),
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}