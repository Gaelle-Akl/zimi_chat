import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

class ChatInputBar extends StatefulWidget {
  final Function(String message) onSend;

  const ChatInputBar({
    super.key,
    required this.onSend,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final message = _controller.text.trim();

    if (message.isEmpty) return;

    widget.onSend(message);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.border,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.add),
            color: AppColors.primary,
            tooltip: 'Add',
          ),


          Expanded(
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),

          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                size: 20,
              ),
              color: Colors.white,
              tooltip: 'Send',
            ),
          ),
        ],
      ),
    );
  }
}