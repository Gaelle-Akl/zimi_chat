import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'en';

  String get currentLanguage => _currentLanguage;

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // Header
      'title': 'Zimi Assistant',
      'subtitle': 'Your food companion',
      'refresh': 'Refresh Chat',

      // Dietary Filters
      'filter_vegan': 'Vegan',
      'filter_gluten_free': 'Gluten-Free',
      'filter_dairy_free': 'Dairy-Free',

      // Quick Action Button Labels
      'action_find_food': 'Find food',
      'action_track_order': 'Track order',
      'action_popular': 'Popular near me',
      'action_deals': 'Deals & offers',
      'action_help': 'Need help',

      // Toggle & Cart Banners
      'show_options': 'Show Options',
      'hide_options': 'Hide Options',
      'cart_total': 'Cart Total',
      'checkout': 'Checkout',
      'order_placed_success': 'Order placed successfully! ID:',

      // Messages sent when clicking quick actions
      'prompt_find_food': 'Find me some food',
      'prompt_track_order': 'Track my order',
      'prompt_popular': 'What is popular near me?',
      'prompt_deals': 'Show me today’s deals',
      'prompt_help': 'I need help',

      // Chat Bar Input
      'input_placeholder': 'Type a message...',
    },
    'fr': {
      // Header
      'title': 'Assistant Zimi',
      'subtitle': 'Votre compagnon culinaire',
      'refresh': 'Rafraîchir le chat',

      // Dietary Filters
      'filter_vegan': 'Végétalien',
      'filter_gluten_free': 'Sans Gluten',
      'filter_dairy_free': 'Sans Lactose',

      // Quick Action Button Labels
      'action_find_food': 'Trouver des plats',
      'action_track_order': 'Suivre la commande',
      'action_popular': 'Populaire à proximité',
      'action_deals': 'Offres & promotions',
      'action_help': 'Besoin d\'aide',

      // Toggle & Cart Banners
      'show_options': 'Afficher les options',
      'hide_options': 'Masquer les options',
      'cart_total': 'Total du panier',
      'checkout': 'Commander',
      'order_placed_success': 'Commande passée avec succès ! N° :',

      // Messages sent when clicking quick actions
      'prompt_find_food': 'Trouve-moi de la nourriture',
      'prompt_track_order': 'Suivre ma commande',
      'prompt_popular': 'Qu\'est-ce qui est populaire près d\'ici ?',
      'prompt_deals': 'Montre-moi les offres du jour',
      'prompt_help': 'J\'ai besoin d\'aide',

      // Chat Bar Input
      'input_placeholder': 'Écrivez un message...',
    },
    'ar': {
      // Header
      'title': 'مساعد زيمي',
      'subtitle': 'رفيقك في الطعام',
      'refresh': 'تحديث المحادثة',

      // Dietary Filters
      'filter_vegan': 'نباتي صرف',
      'filter_gluten_free': 'خالي من الغلوتين',
      'filter_dairy_free': 'خالي من المشتقات الحيوانية',

      // Quick Action Button Labels
      'action_find_food': 'البحث عن طعام',
      'action_track_order': 'تتبع الطلب',
      'action_popular': 'الأكثر شعبية بالقرب مني',
      'action_deals': 'العروض والخصومات',
      'action_help': 'أحتاج مساعدة',

      // Toggle & Cart Banners
      'show_options': 'إظهار الخيارات',
      'hide_options': 'إخفاء الخيارات',
      'cart_total': 'مجموع السلة',
      'checkout': 'إتمام الطلب',
      'order_placed_success': 'تم إرسال الطلب بنجاح! رقم الطلب:',

      // Messages sent when clicking quick actions
      'prompt_find_food': 'ابحث لي عن طعام',
      'prompt_track_order': 'تتبع طلبي',
      'prompt_popular': 'ما هي الأماكن الشائعة بالقرب مني؟',
      'prompt_deals': 'اعرض لي عروض اليوم',
      'prompt_help': 'أحتاج إلى مساعدة',

      // Chat Bar Input
      'input_placeholder': 'اكتب رسالة...',
    },
  };

  void setLanguage(String langCode) {
    if (_currentLanguage != langCode) {
      _currentLanguage = langCode;
      notifyListeners();
    }
  }

  String translate(String key) {
    return _localizedValues[_currentLanguage]?[key] ?? key;
  }
}