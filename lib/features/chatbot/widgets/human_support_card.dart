import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

class HumanSupportCard extends StatelessWidget {
  final VoidCallback onConnect;

  const HumanSupportCard({
    super.key,
    required this.onConnect,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(

        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(

          color: AppColors.border,
        ),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.support_agent_rounded,
                  color: AppColors.primary,
                  size: 23,

                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Text(
                  'Need more help?',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

              ),


            ],
          ),

          const SizedBox(height: 12),

          const Text(
            "I couldn’t find the answer you were looking for. "
            "A support specialist can help you with this.",
            style: TextStyle(
              color: AppColors.secondaryText,
              fontSize: 14,
              height: 1.4,
            ),
          ),
         

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onConnect,
              icon: const Icon(
                Icons.headset_mic_outlined,
                size: 19,

              ),
              label: const Text(

                'Talk to a human',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

              ),
            ),

          ),

        ],

      ),


    );

  }
}