import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../widgets/chat_header.dart';
import '../models/chat_message.dart';
import '../models/chat_message_model.dart';
import '../widgets/quick_actions.dart';
import '../widgets/chat_input_bar.dart';

import '../widgets/delivery_status_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final List<ChatMessageModel> messages = [
    const ChatMessageModel(
      text: "Hi, I'm Zimi, your food delivery assistant.",
      type: MessageType.bot,
      time: '2:22 PM',
    ),

    const ChatMessageModel(
      text: 'Where is my order right now?',
      type: MessageType.user,
      time: '2:24 PM',
    ),

    const ChatMessageModel(
      text:
          'Your order is on its way and should arrive in about 20 minutes. The driver is currently nearby.',
      type: MessageType.bot,
      time: '2:25 PM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const ChatHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    QuickActions(
                      onFindFood: () {
                        debugPrint('Find food pressed');
                      },
                      onTrackOrder: () {
                        debugPrint('Track order pressed');
                      },
                      onPopular: () {
                        debugPrint('Popular near me pressed');
                      },
                      onDeals: () {
                        debugPrint('Deals pressed');
                      },
                      onHelp: () {
                        debugPrint('Help pressed');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                8,
                20,
                16,
              ),
              child: ChatInputBar(
                onSend: (message) {
                  debugPrint('Message sent: $message');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}