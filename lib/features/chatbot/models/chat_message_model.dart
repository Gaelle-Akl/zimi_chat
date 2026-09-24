import 'restaurant_model.dart';

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