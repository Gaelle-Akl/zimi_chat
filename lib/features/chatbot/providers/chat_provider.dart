import 'package:flutter/material.dart';
import '../models/chat_message_model.dart';
import 'cart_provider.dart';
import 'language_provider.dart';
import 'user_preferences_provider.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessageModel> _messages = [];

  List<ChatMessageModel> get messages => List.unmodifiable(_messages);

  ChatProvider() {
    _addInitialGreeting('en');
  }

  void _addInitialGreeting([String langCode = 'en']) {
    final greetings = {
      'en': "Hi! I'm Zimi, your food companion. How can I help you today?",
      'fr': "Bonjour ! Je suis Zimi, votre compagnon culinaire. Comment puis-je vous aider aujourd'hui ?",
      'ar': "مرحباً! أنا زيمي، رفيقك في الطعام. كيف يمكنني مساعدتك اليوم؟",
    };

    _messages.add(
      ChatMessageModel(
        text: greetings[langCode] ?? greetings['en']!,
        isUser: false,
      ),
    );
  }

  String _detectLanguage(String query, String currentAppLang) {
    // Detect Arabic character set
    final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(query);
    if (hasArabic) return 'ar';

    // Detect French key phrases
    final lower = query.toLowerCase();
    if (lower.contains('aide') ||
        lower.contains('commande') ||
        lower.contains('suivre') ||
        lower.contains('offre') ||
        lower.contains('nourriture')) {
      return 'fr';
    }

    return currentAppLang;
  }

  void sendMessage(
      String text,
      UserPreferencesProvider prefsProvider,
      CartProvider cartProvider, [
        LanguageProvider? langProvider,
      ]) {
    final query = text.trim();
    if (query.isEmpty) return;

    _messages.add(ChatMessageModel(text: query, isUser: true));
    notifyListeners();

    final lowerQuery = query.toLowerCase();
    final appLang = langProvider?.currentLanguage ?? 'en';
    final lang = _detectLanguage(query, appLang);

    // 1. HELP / SUPPORT
    if (_matchesKeywords(lowerQuery, [
      'help',
      'aide',
      'مساعدة',
      'اسأل',
      'need help',
      'besoin d\'aide',
      'أحتاج'
    ])) {
      final replies = {
        'en': "I'm here to help! Search for foods like 'burgers', 'pizza', 'sushi', or 'thai', or track an active order.",
        'fr': "Je suis là pour vous aider ! Cherchez des plats comme 'burgers', 'pizza', 'sushi' ou 'thaï', ou suivez une commande.",
        'ar': "أنا هنا للمساعدة! ابحث عن أطعمة مثل 'برجر' أو 'بيتزا' أو 'سوشي' أو 'تايلاندي'، أو تتبع طلبك النشط.",
      };
      _addAiReply(replies[lang] ?? replies['en']!);
      return;
    }

    // 2. TRACK ORDER
    if (_matchesKeywords(lowerQuery, [
      'track',
      'order',
      'suivre',
      'commande',
      'تتبع',
      'الطلب',
      'طلبي'
    ])) {
      if (!cartProvider.hasActiveOrder) {
        final noOrderReplies = {
          'en': "You don't have an active order right now. Add items to your cart and check out first!",
          'fr': "Vous n'avez pas de commande active pour le moment. Ajoutez des articles à votre panier et validez !",
          'ar': "ليس لديك طلب نشط حالياً. أضف عناصر إلى سلتك وقم بإتمام الطلب أولاً!",
        };
        _addAiReply(noOrderReplies[lang] ?? noOrderReplies['en']!);
      } else {
        final statusMessages = {
          'en': "Your food is being prepared 🍳",
          'fr': "Votre repas est en cours de préparation 🍳",
          'ar': "جاري تحضير طعامك الآن 🍳",
        };

        final activeStatus = statusMessages[lang] ?? statusMessages['en']!;

        final statusPrefixes = {
          'en': "📦 Order #${cartProvider.activeOrderId} Status:\n\n$activeStatus",
          'fr': "📦 Statut de la commande #${cartProvider.activeOrderId} :\n\n$activeStatus",
          'ar': "📦 حالة الطلب رقم #${cartProvider.activeOrderId}:\n\n$activeStatus",
        };

        _addAiReply(statusPrefixes[lang] ?? statusPrefixes['en']!);
      }
      return;
    }

    // 3. DEALS / OFFERS / POPULAR
    if (_matchesKeywords(lowerQuery, [
      'deal',
      'offer',
      'popular',
      'offre',
      'promo',
      'populaire',
      'عروض',
      'خصومات',
      'شائعة',
      'الأكثر'
    ])) {
      final dealReplies = {
        'en': "We have special discounts today! 🏷️ What kind of food are you craving?",
        'fr': "Nous avons des réductions spéciales aujourd'hui ! 🏷️ De quoi avez-vous envie ?",
        'ar': "لدينا خصومات خاصة اليوم! 🏷️ ما نوع الطعام الذي تشتهي تناوله؟",
      };
      _addAiReply(dealReplies[lang] ?? dealReplies['en']!);
      return;
    }

    // 4. SEARCH & RECOMMENDATIONS
    List<MenuItemModel> searchResults = _searchMenuItems(lowerQuery, prefsProvider);

    if (searchResults.isNotEmpty) {
      final matchReplies = {
        'en': "Here are fresh options matching your request:",
        'fr': "Voici des options fraîches correspondant à votre demande :",
        'ar': "إليك خيارات طازجة تناسب طلبك:",
      };

      _messages.add(
        ChatMessageModel(
          text: matchReplies[lang] ?? matchReplies['en']!,
          isUser: false,
          menuItems: searchResults,
        ),
      );
      notifyListeners();
      return;
    }

    // 5. FALLBACK
    final fallbackReplies = {
      'en': "I couldn't find exact matches. Try searching for 'Burgers', 'Pizza', 'Sushi', or 'Thai'!",
      'fr': "Je n'ai pas trouvé de correspondance exacte. Essayez de chercher 'Burgers', 'Pizza', 'Sushi' ou 'Thaï' !",
      'ar': "لم أتمكن من العثور على نتائج مطابقة. جرب البحث عن 'برجر' أو 'بيتزا' أو 'سوشي' أو 'تايلاندي'!",
    };
    _addAiReply(fallbackReplies[lang] ?? fallbackReplies['en']!);
  }

  bool _matchesKeywords(String text, List<String> keywords) {
    return keywords.any((kw) => text.contains(kw));
  }

  void updateFilterResults(UserPreferencesProvider prefs, CartProvider cart, [LanguageProvider? langProvider]) {
    final lang = langProvider?.currentLanguage ?? 'en';
    final filterReplies = {
      'en': "Preferences updated! Try searching for your favorite dish to view filtered results.",
      'fr': "Préférences mises à jour ! Essayez de chercher votre plat préféré pour voir les résultats filtrés.",
      'ar': "تم تحديث تفضيلاتك! جرب البحث عن طبقك المفضل لعرض النتائج المفلترة.",
    };
    _addAiReply(filterReplies[lang] ?? filterReplies['en']!);
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
      MenuItemModel(
        id: '8',
        name: 'Pad Thai Noodles',
        category: 'thai',
        price: 13.99,
        description: 'Traditional stir-fried rice noodles with tofu, peanuts, and bean sprouts.',
        imageUrl: 'https://images.unsplash.com/photo-1559847844-5315695dadae?w=400',
        isVegan: true,
        isGlutenFree: true,
        isDairyFree: true,
      ),
    ];

    // Multilingual keyword mapping
    final categorySynonyms = {
      'burgers': ['burger', 'burgers', 'برجر', 'بورجر', 'برغر'],
      'pizza': ['pizza', 'pizzas', 'بيتزا', 'بيتزه'],
      'sushi': ['sushi', 'سوشي', 'سوشى'],
      'thai': ['thai', 'thaï', 'تايلاندي', 'تايلندي', 'تاي', 'باد تاي'],
    };

    return allItems.where((item) {
      if (prefs.isVegan && !item.isVegan) return false;
      if (prefs.isGlutenFree && !item.isGlutenFree) return false;
      if (prefs.isDairyFree && !item.isDairyFree) return false;

      // Generic match for "food" across languages
      if (_matchesKeywords(cleanQuery, ['food', 'nourriture', 'طعام', 'trouver', 'ابحث'])) return true;

      // Category synonym check
      final synonyms = categorySynonyms[item.category.toLowerCase()] ?? [];
      bool categoryMatches = synonyms.any((synonym) => cleanQuery.contains(synonym));

      return categoryMatches ||
          item.name.toLowerCase().contains(cleanQuery) ||
          item.category.toLowerCase().contains(cleanQuery);
    }).toList();
  }

  void _addAiReply(String text) {
    _messages.add(ChatMessageModel(text: text, isUser: false));
    notifyListeners();
  }

  void clearMessages(CartProvider cartProvider, [String langCode = 'en']) {
    _messages.clear();
    _addInitialGreeting(langCode);
    notifyListeners();
  }
}