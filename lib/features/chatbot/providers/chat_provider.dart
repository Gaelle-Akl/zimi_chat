import 'package:flutter/material.dart';
import '../models/chat_message_model.dart';
import '../models/restaurant_model.dart';
import 'user_preferences_provider.dart';
import 'cart_provider.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessageModel> _messages = [];
  String _lastQueryText = '';
  final Set<String> _userQueriedCategories = {};

  List<ChatMessageModel> get messages => List.unmodifiable(_messages);

  final Set<String> _ignoredWords = {
    'want', 'maybe', 'please', 'like', 'some', 'need', 'give', 'show',
    'find', 'get', 'looking', 'for', 'have', 'with', 'what', 'about',
    'would', 'could', 'can', 'you', 'how', 'places', 'place', 'spots', 'spot',
    'near', 'me', 'food'
  };

  final List<Restaurant> _allRestaurants = [
    Restaurant(
      id: 'r1',
      name: 'Mario\'s Pizzeria',
      category: 'Pizza',
      rating: 4.8,
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591',
      menu: [
        MenuItem(
          id: 'm1',
          name: 'Margherita Pizza',
          description: 'Fresh mozzarella, vine tomatoes, basil, and olive oil',
          price: 12.99,
          imageUrl: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3',
          isVegan: false,
          isDairyFree: false,
          isGlutenFree: false,
        ),
        MenuItem(
          id: 'm2',
          name: 'Vegan Mushroom Pizza',
          description: 'Wild mushrooms, cashew cheese, garlic, and herbs',
          price: 14.99,
          imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591',
          isVegan: true,
          isDairyFree: true,
          isGlutenFree: true,
        ),
      ],
    ),
    Restaurant(
      id: 'r2',
      name: 'Bella Italia Bistro',
      category: 'Pizza',
      rating: 4.7,
      imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5',
      menu: [
        MenuItem(
          id: 'm4',
          name: 'Gluten-Free Truffle Pasta',
          description: 'Gluten-free penne, black truffle sauce, mushrooms',
          price: 16.99,
          imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3d5d6281293',
          isVegan: true,
          isDairyFree: true,
          isGlutenFree: true,
        ),
        MenuItem(
          id: 'm5',
          name: 'Four Cheese Pizza',
          description: 'Gorgonzola, mozzarella, parmesan, and ricotta',
          price: 15.50,
          imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591',
          isVegan: false,
          isDairyFree: false,
          isGlutenFree: false,
        ),
      ],
    ),
    Restaurant(
      id: 'r3',
      name: 'Burger Haven',
      category: 'Burgers',
      rating: 4.6,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
      menu: [
        MenuItem(
          id: 'b1',
          name: 'Classic Cheeseburger',
          description: 'Angus beef patty, cheddar cheese, lettuce, tomato',
          price: 10.99,
          imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
          isVegan: false,
          isDairyFree: false,
          isGlutenFree: false,
        ),
        MenuItem(
          id: 'b2',
          name: 'Gluten-Free Veggie Burger',
          description: 'Black bean & quinoa patty on a gluten-free bun',
          price: 12.49,
          imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349',
          isVegan: true,
          isDairyFree: true,
          isGlutenFree: true,
        ),
      ],
    ),
    Restaurant(
      id: 'r4',
      name: 'Green Street Burgers',
      category: 'Burgers',
      rating: 4.8,
      imageUrl: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90',
      menu: [
        MenuItem(
          id: 'b4',
          name: 'Beyond Meat Vegan Burger',
          description: 'Plant-based patty, vegan cheese, lettuce, avocado',
          price: 13.99,
          imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349',
          isVegan: true,
          isDairyFree: true,
          isGlutenFree: true,
        ),
      ],
    ),
    Restaurant(
      id: 'r5',
      name: 'Sakura Sushi Bar',
      category: 'Sushi',
      rating: 4.9,
      imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c',
      menu: [
        MenuItem(
          id: 's1',
          name: 'Salmon Roll Set',
          description: 'Fresh Atlantic salmon rolls with seasoned rice',
          price: 16.99,
          imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c',
          isVegan: false,
          isDairyFree: true,
          isGlutenFree: true,
        ),
        MenuItem(
          id: 's2',
          name: 'Avocado Cucumber Roll',
          description: 'Creamy avocado and fresh cucumber wrapped in nori',
          price: 8.99,
          imageUrl: 'https://images.unsplash.com/photo-1611143669185-af224c5e3252',
          isVegan: true,
          isDairyFree: true,
          isGlutenFree: true,
        ),
      ],
    ),
    Restaurant(
      id: 'r6',
      name: 'Bangkok Spice Thai',
      category: 'Thai',
      rating: 4.7,
      imageUrl: 'https://images.unsplash.com/photo-1559314809-0d155014e29e',
      menu: [
        MenuItem(
          id: 't1',
          name: 'Pad Thai Noodles',
          description: 'Rice noodles, bean sprouts, peanuts, tamarind sauce',
          price: 13.99,
          imageUrl: 'https://images.unsplash.com/photo-1559314809-0d155014e29e',
          isVegan: true,
          isDairyFree: true,
          isGlutenFree: true,
        ),
        MenuItem(
          id: 't2',
          name: 'Vegan Green Curry',
          description: 'Coconut green curry, bamboo shoots, eggplant, basil',
          price: 15.49,
          imageUrl: 'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd',
          isVegan: true,
          isDairyFree: true,
          isGlutenFree: true,
        ),
      ],
    ),
  ];

  void sendMessage(String text, UserPreferencesProvider prefs, CartProvider cart) {
    final timeStr = _getCurrentFormattedTime();
    _messages.add(ChatMessageModel(text: text, isUser: true, time: timeStr));
    _lastQueryText = text;
    notifyListeners();
    _generateAiResponse(text, prefs, cart, timeStr);
  }

  void updateFilterResults(UserPreferencesProvider prefs, CartProvider cart) {
    if (_lastQueryText.isNotEmpty) {
      _generateAiResponse(_lastQueryText, prefs, cart, _getCurrentFormattedTime(), updateLastMessage: true);
    }
  }

  void clearMessages([CartProvider? cart]) {
    _messages.clear();
    _lastQueryText = '';
    _userQueriedCategories.clear();

    // Clears active order tracking state on refresh
    if (cart != null) {
      cart.resetOrder();
    }

    notifyListeners();
  }

  void _generateAiResponse(
      String text,
      UserPreferencesProvider prefs,
      CartProvider cart,
      String timeStr, {
        bool updateLastMessage = false,
      }) {
    final cleanInput = text.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase().trim();
    final bool isAnyFilterActive = prefs.isVegan || prefs.isGlutenFree || prefs.isDairyFree;

    // Track order check with friendly response messaging
    if (cleanInput.contains('track order')) {
      final statusMsg = cart.hasActiveOrder
          ? "Order #${cart.activeOrderId} Status: ${cart.activeOrderStatus}\n\nOur driver will be on the way shortly! 🛵💨"
          : "You don't have any active orders right now! Ready to grab something tasty? 🍔";

      _postResponse(
        ChatMessageModel(text: statusMsg, isUser: false, time: timeStr),
        updateLastMessage,
      );
      return;
    }

    // Find food prompt
    if (cleanInput.contains('find food')) {
      _postResponse(
        ChatMessageModel(
          text: "What type of food are you craving today? Here are available options in our menu:\n• Thai\n• Sushi\n• Pizza\n• Burgers",
          isUser: false,
          time: timeStr,
        ),
        updateLastMessage,
      );
      return;
    }

    // Popular near me
    if (cleanInput.contains('popular') || cleanInput.contains('popular near me')) {
      List<Restaurant> popular = _filterRestaurantsByPrefs(_allRestaurants, prefs);
      _postResponse(
        ChatMessageModel(
          text: "Here are top-rated popular spots near you:",
          isUser: false,
          time: timeStr,
          recommendedRestaurants: popular,
        ),
        updateLastMessage,
      );
      return;
    }

    // Deals & offers (Only show queried/selected categories)
    if (cleanInput.contains('deals') || cleanInput.contains('offers')) {
      if (_userQueriedCategories.isEmpty) {
        _postResponse(
          ChatMessageModel(
            text: "Please search for or select a food type first (e.g. Thai, Sushi, Pizza, Burgers), so I can show relevant deals for your selection!",
            isUser: false,
            time: timeStr,
          ),
          updateLastMessage,
        );
        return;
      }

      List<Restaurant> dealRestaurants = _allRestaurants.where((r) {
        return _userQueriedCategories.contains(r.category.toLowerCase());
      }).toList();

      List<Restaurant> filteredDeals = _filterRestaurantsByPrefs(dealRestaurants, prefs);

      _postResponse(
        ChatMessageModel(
          text: "Here are active deals on your selected foods:",
          isUser: false,
          time: timeStr,
          recommendedRestaurants: filteredDeals,
        ),
        updateLastMessage,
      );
      return;
    }

    if (cleanInput.contains('need help') || cleanInput.contains('help')) {
      _postResponse(
        ChatMessageModel(
          text: "I can help you discover meals! You can search for 'Pizza', 'Burger', 'Sushi', or 'Thai', check 'Deals & offers', or tap 'Track order'.",
          isUser: false,
          time: timeStr,
        ),
        updateLastMessage,
      );
      return;
    }

    final words = cleanInput
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 2 && !_ignoredWords.contains(w))
        .toList();

    List<Restaurant> matchingRestaurants = [];

    for (var restaurant in _allRestaurants) {
      final rName = restaurant.name.toLowerCase();
      final rCat = restaurant.category.toLowerCase();

      List<MenuItem> filteredMenuItems = restaurant.menu.where((item) {
        if (!isAnyFilterActive) return true;
        if (prefs.isVegan && !item.isVegan) return false;
        if (prefs.isGlutenFree && !item.isGlutenFree) return false;
        if (prefs.isDairyFree && !item.isDairyFree) return false;
        return true;
      }).toList();

      if (filteredMenuItems.isEmpty) continue;

      bool categoryOrNameMatch = words.any((w) => rCat.contains(w) || rName.contains(w));

      if (categoryOrNameMatch) {
        _userQueriedCategories.add(rCat);
        matchingRestaurants.add(
          Restaurant(
            id: restaurant.id,
            name: restaurant.name,
            category: restaurant.category,
            rating: restaurant.rating,
            imageUrl: restaurant.imageUrl,
            menu: filteredMenuItems,
          ),
        );
      } else {
        List<MenuItem> matchingItems = filteredMenuItems.where((item) {
          final itemName = item.name.toLowerCase();
          return words.any((w) => itemName.contains(w));
        }).toList();

        if (matchingItems.isNotEmpty) {
          _userQueriedCategories.add(rCat);
          matchingRestaurants.add(
            Restaurant(
              id: restaurant.id,
              name: restaurant.name,
              category: restaurant.category,
              rating: restaurant.rating,
              imageUrl: restaurant.imageUrl,
              menu: matchingItems,
            ),
          );
        }
      }
    }

    List<String> activeFilterNames = [];
    if (prefs.isVegan) activeFilterNames.add('Vegan');
    if (prefs.isGlutenFree) activeFilterNames.add('Gluten-Free');
    if (prefs.isDairyFree) activeFilterNames.add('Dairy-Free');
    final filterLabel = activeFilterNames.join(', ');

    ChatMessageModel aiMsg;

    if (matchingRestaurants.isNotEmpty) {
      aiMsg = ChatMessageModel(
        text: isAnyFilterActive
            ? "Here are $filterLabel options matching your search:"
            : "Here are multiple options available for your search:",
        isUser: false,
        time: timeStr,
        recommendedRestaurants: matchingRestaurants,
      );
    } else {
      aiMsg = ChatMessageModel(
        text: isAnyFilterActive
            ? "No $filterLabel options matched your search for '$text'. Try another query or adjust dietary filters!"
            : "No items matched your search. Try searching for 'Thai', 'Sushi', 'Pizza', or 'Burgers'!",
        isUser: false,
        time: timeStr,
      );
    }

    _postResponse(aiMsg, updateLastMessage);
  }

  List<Restaurant> _filterRestaurantsByPrefs(List<Restaurant> source, UserPreferencesProvider prefs) {
    bool isAnyFilterActive = prefs.isVegan || prefs.isGlutenFree || prefs.isDairyFree;
    List<Restaurant> result = [];

    for (var r in source) {
      var validMenu = r.menu.where((item) {
        if (!isAnyFilterActive) return true;
        if (prefs.isVegan && !item.isVegan) return false;
        if (prefs.isGlutenFree && !item.isGlutenFree) return false;
        if (prefs.isDairyFree && !item.isDairyFree) return false;
        return true;
      }).toList();

      if (validMenu.isNotEmpty) {
        result.add(Restaurant(
          id: r.id,
          name: r.name,
          category: r.category,
          rating: r.rating,
          imageUrl: r.imageUrl,
          menu: validMenu,
        ));
      }
    }
    return result;
  }

  void _postResponse(ChatMessageModel aiMsg, bool updateLastMessage) {
    if (updateLastMessage && _messages.isNotEmpty && !_messages.last.isUser) {
      _messages[_messages.length - 1] = aiMsg;
    } else {
      _messages.add(aiMsg);
    }
    notifyListeners();
  }

  String _getCurrentFormattedTime() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}