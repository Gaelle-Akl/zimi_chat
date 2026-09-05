import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            // Header will go here
            Container(
              height: 80,
              color: AppColors.primary,
              child: const Center(
                child: Text(
                  'Delivery Assistant',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Chat content will go here
            const Expanded(
              child: Center(
                child: Text(
                  'Hello',
                ),
              ),
            ),

            // Input bar will go here
            Container(
              height: 70,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}