import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant_model.dart';
import '../providers/cart_provider.dart';

class FoodRecommendationCard extends StatelessWidget {
  final MenuItem item;
  final String restaurantName;

  const FoodRecommendationCard({
    super.key,
    required this.item,
    required this.restaurantName,
  });

  String _getItemImageUrl() {
    if (item.imageUrl != null && item.imageUrl!.isNotEmpty) {
      return item.imageUrl!;
    }

    // Dynamic image lookup based on food type
    final nameLower = item.name.toLowerCase();
    if (nameLower.contains('burger')) {
      return 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300';
    } else if (nameLower.contains('pizza')) {
      return 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=300';
    } else if (nameLower.contains('sushi') || nameLower.contains('roll')) {
      return 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=300';
    } else if (nameLower.contains('pad thai') || nameLower.contains('curry') || nameLower.contains('soup')) {
      return 'https://images.unsplash.com/photo-1559314809-0d155014e29e?w=300';
    }

    return 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Item Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              _getItemImageUrl(),
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 70,
                height: 70,
                color: const Color(0xFFF7FAFC),
                child: const Icon(Icons.fastfood, color: Color(0xFFFF5252)),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF2D3748),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    const Text(
                      '4.7',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      ' · 20-30 min · ',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.restaurant, size: 12, color: Color(0xFFFF5252)),
                    const SizedBox(width: 4),
                    Text(
                      restaurantName,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Button (+ Add)
          ElevatedButton.icon(
            onPressed: () {
              final cartProvider = Provider.of<CartProvider>(context, listen: false);
              cartProvider.addItem(item);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.name} added to cart!'),
                  duration: const Duration(seconds: 2),
                  backgroundColor: const Color(0xFFFF5252),
                ),
              );
            },
            icon: const Icon(Icons.add, size: 16, color: Colors.white),
            label: const Text(
              'Add',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5252),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}