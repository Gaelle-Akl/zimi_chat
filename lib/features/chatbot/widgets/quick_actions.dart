import 'package:flutter/material.dart';

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

  Widget _buildOutlinedButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: const Color(0xFFFF5252)),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF2D3748),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildOutlinedButton(
                icon: Icons.restaurant,
                label: 'Find food',
                onTap: onFindFood,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildOutlinedButton(
                icon: Icons.location_on,
                label: 'Track order',
                onTap: onTrackOrder,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildOutlinedButton(
                icon: Icons.local_fire_department,
                label: 'Popular near me',
                onTap: onPopular,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildOutlinedButton(
                icon: Icons.local_offer,
                label: 'Deals & offers',
                onTap: onDeals,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.42,
          child: _buildOutlinedButton(
            icon: Icons.help_outline,
            label: 'Need help',
            onTap: onHelp,
          ),
        ),
      ],
    );
  }
}