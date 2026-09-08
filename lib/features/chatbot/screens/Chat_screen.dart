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
            
             const ChatHeader()
              
            // Chat content will go here
            const Expanded(
              child: Center(
                child: Text(
                  'Hello',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize : 16,
                  )
                ),
              ),
            ),

            // Input bar will go here
            Container(
              height: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}