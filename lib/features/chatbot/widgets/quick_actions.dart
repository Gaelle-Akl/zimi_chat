import 'package:flutter/material.dart';
import 'quick_action_button.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback onFindFood;
  final VoidCallback onTrackOrder;
  final VoidCallback onPopular;
  final VoidCallback onDeals;
  final VoidCallback onHelp;

  const QuickActions({
    super.key,
    required this.onFindFood,
    required this.onTrackOrder,
    required this.onPopular,
    required this.onDeals,
    required this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QuickActionButton(
                  icon: Icons.restaurant_rounded,
                  label: 'Find food',
                  onPressed: onFindFood,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: QuickActionButton(
                  icon: Icons.location_on_rounded,
                  label: 'Track order',
                  onPressed: onTrackOrder,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: QuickActionButton(
                  icon: Icons.local_fire_department_rounded,
                  label: 'Popular near me',
                  onPressed: onPopular,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: QuickActionButton(
                  icon: Icons.local_offer_rounded,
                  label: 'Deals & offers',
                  onPressed: onDeals,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 150,
              child: QuickActionButton(
                icon: Icons.help_outline_rounded,
                label: 'Need help',
                onPressed: onHelp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}