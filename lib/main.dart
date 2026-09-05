import 'package:flutter/material.dart';

import 'app/theme/app_theme.dart';
import 'features/chatbot/screens/chat_screen.dart';

void main() {
  runApp(const ZimiApp());
}

class ZimiApp extends StatelessWidget {
  const ZimiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'zimi initial design',
      theme: AppTheme.lightTheme,
      home: const ChatScreen(),
    );
  }
}

