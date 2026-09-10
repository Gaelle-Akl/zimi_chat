import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import 'quantity_selector.dart';

class MenuItemCard extends StatelessWidget {
  final String name;
  final String price;
  final String? imageUrl;
  final int quantity;

  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const MenuItemCard({
    super.key,
    required this.name,
    required this.price,
    this.imageUrl,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _DishImage(
            imageUrl: imageUrl,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  price,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 10),

                if (quantity == 0)
                  SizedBox(
                    height: 36,
                    child: OutlinedButton.icon(
                      onPressed: onAdd,
                      icon: const Icon(
                        Icons.add,
                        size: 17,
                      ),
                      label: const Text('Add'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(
                          color: AppColors.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                      ),
                    ),
                  )
                else
                  QuantitySelector(
                    quantity: quantity,
                    onAdd: onAdd,
                    onRemove: onRemove,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DishImage extends StatelessWidget {
  final String? imageUrl;

  const _DishImage({
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        width: 92,
        height: 92,
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return _placeholder();
                },
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.primaryLight,
      child: const Icon(
        Icons.restaurant_outlined,
        color: AppColors.primary,
        size: 30,
      ),
    );
  }
}