import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../models/chat_message_model.dart';

class ChatMessage extends StatelessWidget {
  final ChatMessageModel message;

  const ChatMessage({
    super.key,
    required this.message,
  });

  bool get isUser => message.type == MessageType.user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 7,
      ),

      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,

        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          if (!isUser) ...[
            _buildBotAvatar(),
            const SizedBox(width: 10),
          ],

          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,

              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 13,
                  ),

                  decoration: BoxDecoration(
                    color: isUser
                        ? AppColors.userBubble
                      : AppColors.aiBubble,

                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),

                      bottomLeft: Radius.circular(
                        isUser ? 18 : 4,
                      ),

                      bottomRight: Radius.circular(
                        isUser ? 4 : 18,
                      ),
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Text(
                    message.text,

                    style: TextStyle(
                      color: isUser
                          ? Colors.white
                          : AppColors.text,

                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  message.time,

                  style: const TextStyle(
                    color: AppColors.textLight,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotAvatar() {
    return Container(
      width: 38,
      height: 38,

      decoration: BoxDecoration(
        color: AppColors.primaryLight.withOpacity(0.25),
        shape: BoxShape.circle,
      ),

      child: const Icon(
        Icons.smart_toy_outlined,
        color: AppColors.primary,
        size: 23,
      ),
    );
  }
}