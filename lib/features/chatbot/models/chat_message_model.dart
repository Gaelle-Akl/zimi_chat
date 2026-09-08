enum MessageType {
  user,
  bot,
}

class ChatMessageModel {
  final String text;
  final MessageType type;
  final String time;

  const ChatMessageModel({
    required this.text,
    required this.type,
    required this.time,
  });
}