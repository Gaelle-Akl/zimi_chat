import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

class WelcomeState extends StatelessWidget {
  const WelcomeState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 28),

        const Text(
          'Zimi Assistant',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Your food companion',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.secondaryText,
          ),
        ),

        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.smart_toy_outlined,
                color: AppColors.primary,
                size: 22,
              ),

              SizedBox(width: 10),

              Expanded(
                child: Text(
                  'Hi! I can help you find food, track your order, discover popular places, and more. What can I do for you?',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: AppColors.text,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}