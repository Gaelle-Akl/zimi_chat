import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../widgets/chat_header.dart';
import '../models/chat_message.dart';
import '../models/chat_message_model.dart';
import '../widgets/quick_actions.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/ai_message_bubble.dart';
import '../widgets/user_message_bubble.dart';
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
  void _sendMessage(String message){
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12: now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2,'0');
    final period = now.period ==DayPeriod.am ? 'AM':'PM';

    final currentTime = '$hour:$minute $period';

    setState((){
      messages.add(
        ChatMessageModel(
          text: message,
          type:MessageType.user,
          time:currentTime,

        ),
      );
    });
  }

//currently working on
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: Column(
              children: [
                // ─────────────────────────────
                // HEADER
                // ─────────────────────────────
                const ChatHeader(),

                // ─────────────────────────────
                // CHAT CONTENT
                // ─────────────────────────────
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    children: [
                      // Messages
                      ...messages.map(
                        (message) {
                          if (message.type == MessageType.bot) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 12,
                              ),
                              child: AiMessageBubble(
                                message: message.text,
                                time: message.time,
                              ),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: UserMessageBubble(
                              message: message.text,
                              time: message.time,
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      // Quick actions
                      QuickActions(
                        onFindFood: () {
                          _sendMessage('Find me some food');
                        },
                        onTrackOrder: () {
                          _sendMessage('Track my order');
                        },
                        onPopular: () {
                          _sendMessage('What is popular near me?');
                        },
                        onDeals: () {
                          _sendMessage('Show me today’s deals');
                        },
                        onHelp: () {
                          _sendMessage('I need help');
                        },
                      ),
                    ],
                  ),
                ),

                // ─────────────────────────────
                // INPUT BAR
                // ─────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    8,
                    20,
                    16,
                  ),
                  child: ChatInputBar(
                    onSend: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}