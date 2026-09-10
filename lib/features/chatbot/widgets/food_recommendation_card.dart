import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import 'quantity_selector.dart';

class FoodRecommendationCard extends StatelessWidget {
  final String foodName;
  final String restaurantName;
  final double rating;
  final String deliveryTime;
  final String price;
  final String? imageUrl;

  final int quantity;

  final VoidCallback onView;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const FoodRecommendationCard({
    super.key,
    required this.foodName,
    required this.restaurantName,
    required this.rating,
    required this.deliveryTime,
    required this.price,
    this.imageUrl,
    required this.quantity,
    required this.onView,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // Change from: color: AppColors.white,
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _FoodImage(
            imageUrl: imageUrl,
          ),

          const SizedBox(width: 12),


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),


                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.warning,
                      size: 16,
                    ),

                    const SizedBox(width: 3),

                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Text(
                      '  ·  ',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),

                    Text(
                      deliveryTime,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),

                    const Text(
                      '  ·  ',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),

                    Text(
                      price,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    const Icon(
                      Icons.restaurant_rounded,
                      color: AppColors.primary,
                      size: 14,
                    ),

                    const SizedBox(width: 4),

                    Expanded(
                      child: Text(
                        restaurantName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 9),


                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _ViewButton(
                      onPressed: onView,
                    ),

                    const SizedBox(width: 7),

                    if (quantity == 0)
                      _AddButton(
                        onPressed: onAdd,
                      )
                    else
                      QuantitySelector(
                        quantity: quantity,
                        onAdd: onAdd,
                        onRemove: onRemove,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


//Food Image


class _FoodImage extends StatelessWidget {
  final String? imageUrl;

  const _FoodImage({
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        width: 88,
        height: 88,
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, _) {
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
        Icons.fastfood_rounded,
        color: AppColors.primary,
        size: 30,
      ),
    );
  }
}


// View Button


class _ViewButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ViewButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'View',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// Add Button


class _AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.add,
          size: 16,
        ),
        label: const Text(
          'Add',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          // Change from: foregroundColor: AppColors.white,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}