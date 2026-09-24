import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../widgets/zimi_avatar.dart';

class WelcomeSection extends StatelessWidget {
  final ValueChanged<String>? onActionSelected;

  const WelcomeSection({
    super.key,
    this.onActionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          25,
          20,
          20,
        ),

        child: Column(
          children: [
            // ─────────────────────────
            // Zimi avatar
            // ─────────────────────────
            const ZimiAvatar(
              size: 105,
            ),

            const SizedBox(height: 18),

            const Text(
              'Hi there! 👋',

              textAlign: TextAlign.center,

              style: TextStyle(
                color: AppColors.text,
                fontSize: 27,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              "I'm Zimi, your food delivery assistant.\n"
              'How can I help you today?',

              textAlign: TextAlign.center,

              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),
            _buildActionGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.restaurant_rounded,
                label: 'Find food',
                action: 'Find food',
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _buildActionButton(
                icon: Icons.location_on_rounded,
                label: 'Track order',
                action: 'Track order',
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.local_fire_department_rounded,
                label: 'Popular near me',
                action: 'Popular near me',
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _buildActionButton(
                icon: Icons.local_offer_rounded,
                label: 'Deals & offers',
                action: 'Deals & offers',
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 170,
            child: _buildActionButton(
              icon: Icons.help_outline_rounded,
              label: 'Need help',
              action: 'Need help',
            
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required String action,
  }) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: () {
          onActionSelected?.call(action);
        },

        borderRadius: BorderRadius.circular(22),

        child: Container(
          height: 58,

          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(22),

            border: Border.all(
              color: AppColors.border,
              width: 1.2,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.025),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: 21,
              ),

              const SizedBox(width: 10),

              Flexible(
                child: Text(
                  label,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}