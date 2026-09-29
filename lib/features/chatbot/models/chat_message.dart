enum MessageType { user, ai, system }

class ChatMessageModel {
  final String text;
  final bool isUser;
  final String time;
  final MessageType type;

  ChatMessageModel({
    required this.text,
    required this.isUser,
    required this.time,
    MessageType? type,
  }) : type = type ?? (isUser ? MessageType.user : MessageType.ai);
}