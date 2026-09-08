import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_message.dart';
import '../widgets/chat_message_model.dart';

class ChatScreen extends StatelessWidget {
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
              
            // Chat content will go here
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  top: 18,
                  bottom:20,
                ),
                
                itemCount:messages.length,

                itemBuilder: (context,index),
                  return ChatMessage(
                    message:messages[index],
                  )
                 
                ),
            ),
          ],
            ),

            // Input bar will go here
            Container(
              height: 20,
              color: Colors.white,
            ),
    
        ),
      ),
    
  }
}