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

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }

  void sendMessage(String text, UserPreferencesProvider userPrefs) async {
    if (text.trim().isEmpty) return;

    _messages.add(ChatMessage(text: text, isUser: true));
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

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

    if (detectedCategory.isNotEmpty) {
      final filteredList = mockRestaurants.where((rest) {
        if (rest.category != detectedCategory) return false;

        final hasMatchingItems = rest.menu.any((item) {
          if (userPrefs.isVegetarian && !item.isVegan) return false;
          if (userPrefs.isDairyFree && !item.isDairyFree) return false;
          if (userPrefs.isGlutenFree && !item.isGlutenFree) return false;
          return true;
        });

        return hasMatchingItems;
      }).toList();

      if (filteredList.isNotEmpty) {
        String filterNotice = '';
        if (userPrefs.isVegetarian) filterNotice += ' (Vegan)';
        if (userPrefs.isDairyFree) filterNotice += ' (Dairy-Free)';
        if (userPrefs.isGlutenFree) filterNotice += ' (Gluten-Free)';

        _messages.add(
          ChatMessage(
            text: 'Here are top spots for $detectedCategory$filterNotice:',
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
          'Hello , I will be your assitant today! \ I can help you find spots! Try asking for "pizza", "burgers", or "ice cream".',
          isUser: false,
        ),
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}