import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          color: AppColors.primary,
          onPressed: onRemove,
        ),
        Text(
          '$quantity',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle),
          color: AppColors.primary,
          onPressed: onAdd,
        ),
      ],
    );
  }
}