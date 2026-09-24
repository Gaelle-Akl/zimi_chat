import '../models/restaurant_model.dart';

class ChatMessageModel {
  final String text;
  final bool isUser;
  final String time;
  final List<Restaurant>? recommendedRestaurants;

  ChatMessageModel({
    required this.text,
    required this.isUser,
    String? time,
    this.recommendedRestaurants,
  }) : time = time ?? _getCurrentTime();

  static String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour == 0 ? 12 : (now.hour > 12 ? now.hour - 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}