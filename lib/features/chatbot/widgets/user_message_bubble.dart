import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

class UserMessageBubble extends StatelessWidget {
  final String message;
  final String time;

  const UserMessageBubble({
    super.key,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 70,
        right: 24,
        top: 8,
        bottom: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
            decoration: const BoxDecoration(
              color: AppColors.userBubble,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            time,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}