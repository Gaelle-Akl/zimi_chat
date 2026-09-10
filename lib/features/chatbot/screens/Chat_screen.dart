import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/app_colors.dart';
import '../providers/cart_provider.dart';
import '../providers/chat_provider.dart';
import '../providers/user_preferences_provider.dart';
import '../widgets/food_recommendation_card.dart';
import '../widgets/cart_bottom_sheet.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _textController.text;
    if (text.trim().isNotEmpty) {
      final userPrefs = context.read<UserPreferencesProvider>();
      context.read<ChatProvider>().sendMessage(text, userPrefs);
      _textController.clear();
    }
  }

  void _handleRefresh() {
    // Clear chat history
    context.read<ChatProvider>().clearMessages();
    // Clear cart state optional reset on conversation restart
    context.read<CartProvider>().clearCart();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chat restarted!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    final userPrefs = context.watch<UserPreferencesProvider>();
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header Bar
            Container(
              height: 100,
              width: double.infinity,
              color: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      'Delivery Assistant',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white, size: 26),
                      tooltip: 'Refresh Conversation',
                      onPressed: _handleRefresh,
                    ),
                  ),
                ],
              ),
            ),

            // Message History List
            Expanded(
              child: chatProvider.messages.isEmpty
                  ? const Center(
                child: Text(
                  'Hello! How can I help with your order?',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 16,
                  ),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: chatProvider.messages.length,
                itemBuilder: (context, index) {
                  final msg = chatProvider.messages[index];

                  return Column(
                    crossAxisAlignment: msg.isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      // 1. Text Message Bubble
                      Align(
                        alignment: msg.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: msg.isUser
                                ? AppColors.primary
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            msg.text,
                            style: TextStyle(
                              color: msg.isUser
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),

                      // 2. Filtered Food Recommendation Cards
                      if (!msg.isUser && msg.recommendedRestaurants != null)
                        ...msg.recommendedRestaurants!.expand((restaurant) {
                          // Filter menu items based on active user preference toggles
                          final filteredMenu = restaurant.menu.where((menuItem) {
                            if (userPrefs.isVegetarian && !menuItem.isVegan) {
                              return false;
                            }
                            if (userPrefs.isDairyFree && !menuItem.isDairyFree) {
                              return false;
                            }
                            return true;
                          }).toList();

                          return filteredMenu.map((menuItem) {
                            final currentQuantity =
                            cartProvider.getQuantity(menuItem.id);

                            return Container(
                              constraints: const BoxConstraints(maxWidth: 400),
                              margin: const EdgeInsets.only(top: 8, bottom: 4),
                              child: FoodRecommendationCard(
                                foodName: menuItem.name,
                                restaurantName: restaurant.name,
                                rating: restaurant.rating,
                                deliveryTime: '20-30 min',
                                price: '\$${menuItem.price.toStringAsFixed(2)}',
                                imageUrl: restaurant.imageUrl,
                                quantity: currentQuantity,
                                onView: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context) => Container(
                                      padding: const EdgeInsets.all(24),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            menuItem.name,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text('Restaurant: ${restaurant.name}'),
                                          Text('Rating: ⭐ ${restaurant.rating}'),
                                          Text(
                                            'Price: \$${menuItem.price.toStringAsFixed(2)}',
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            'Freshly prepared and delivered hot right to your doorstep.',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                onAdd: () {
                                  context.read<CartProvider>().addItem(menuItem);
                                },
                                onRemove: () {
                                  context.read<CartProvider>().removeItem(menuItem.id);
                                },
                              ),
                            );
                          });
                        }),
                    ],
                  );
                },
              ),
            ),

            // Loading indicator when bot is thinking
            if (chatProvider.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CircularProgressIndicator(),
              ),

            // Floating Cart Summary Bar
            if (cartProvider.itemCount > 0)
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => const CartBottomSheet(),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            '${cartProvider.itemCount} ${cartProvider.itemCount == 1 ? 'item' : 'items'} added',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            // Dietary Preference Toggles Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: Colors.grey[100],
              child: Row(
                children: [
                  const Text(
                    'Filters: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Vegan'),
                    selected: userPrefs.isVegetarian,
                    onSelected: (_) => userPrefs.toggleVegetarian(),
                    selectedColor: AppColors.primary.withAlpha(50),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Dairy-Free'),
                    selected: userPrefs.isDairyFree,
                    onSelected: (_) => userPrefs.toggleDairyFree(),
                    selectedColor: AppColors.primary.withAlpha(50),
                  ),
                ],
              ),
            ),

            // Input Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _handleSend(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: AppColors.primary),
                    onPressed: _handleSend,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}