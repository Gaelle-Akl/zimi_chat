import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/theme/app_theme.dart';
import 'features/chatbot/providers/cart_provider.dart';
import 'features/chatbot/providers/chat_provider.dart';
import 'features/chatbot/providers/user_preferences_provider.dart';
import 'features/chatbot/screens/chat_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserPreferencesProvider()),
      ],
      child: const ZimiApp(),
    ),
  );
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