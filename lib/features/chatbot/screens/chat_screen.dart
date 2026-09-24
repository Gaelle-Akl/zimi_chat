import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chat_provider.dart';
import '../providers/user_preferences_provider.dart';
import '../providers/cart_provider.dart';

import '../widgets/chat_header.dart';
import '../widgets/user_message_bubble.dart';
import '../widgets/ai_message_bubble.dart';
import '../widgets/quick_actions.dart';
import '../widgets/cart_bottom_sheet.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _showQuickActions = true;

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSendMessage(String text) {
    if (text.trim().isEmpty) return;
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final userPrefs = Provider.of<UserPreferencesProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);

    chatProvider.sendMessage(text, userPrefs, cart);
    _textController.clear();
    _scrollToBottom();
  }

  void _showCartBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CartBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final userPrefs = Provider.of<UserPreferencesProvider>(context);
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(
        child: Column(
          children: [
            const ChatHeader(),

            // Preference Filter Chips
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FilterChip(
                    label: const Text('Vegan'),
                    selected: userPrefs.isVegan,
                    onSelected: (selected) {
                      userPrefs.toggleVegan();
                      chatProvider.updateFilterResults(userPrefs, cart);
                    },
                    selectedColor: const Color(0xFFFF5252).withValues(alpha: 0.2),
                    checkmarkColor: const Color(0xFFFF5252),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Gluten-Free'),
                    selected: userPrefs.isGlutenFree,
                    onSelected: (selected) {
                      userPrefs.toggleGlutenFree();
                      chatProvider.updateFilterResults(userPrefs, cart);
                    },
                    selectedColor: const Color(0xFFFF5252).withValues(alpha: 0.2),
                    checkmarkColor: const Color(0xFFFF5252),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Dairy-Free'),
                    selected: userPrefs.isDairyFree,
                    onSelected: (selected) {
                      userPrefs.toggleDairyFree();
                      chatProvider.updateFilterResults(userPrefs, cart);
                    },
                    selectedColor: const Color(0xFFFF5252).withValues(alpha: 0.2),
                    checkmarkColor: const Color(0xFFFF5252),
                  ),
                ],
              ),
            ),

            // Messages View
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: chatProvider.messages.length,
                itemBuilder: (context, index) {
                  final msg = chatProvider.messages[index];
                  if (msg.isUser) {
                    return UserMessageBubble(
                      message: msg.text,
                    );
                  } else {
                    return AiMessageBubble(
                      message: msg,
                    );
                  }
                },
              ),
            ),

            // View Cart Floating Bar
            if (cart.totalItemCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _showCartBottomSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5252),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${cart.totalItemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Text(
                        'View Cart & Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '\$${cart.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Quick Actions Toggle Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showQuickActions = !_showQuickActions;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _showQuickActions ? 'Hide Quick Actions' : 'Show Quick Actions',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            _showQuickActions
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            size: 18,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Quick Action Buttons Grid
            if (_showQuickActions)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: QuickActions(
                  onFindFood: () => _handleSendMessage('Find food'),
                  onTrackOrder: () => _handleSendMessage('Track order'),
                  onPopular: () => _handleSendMessage('Popular near me'),
                  onDeals: () => _handleSendMessage('Deals & offers'),
                  onHelp: () => _handleSendMessage('Need help'),
                ),
              ),

            // Input Bar with Plus (+) Button
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _showCartBottomSheet,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Color(0xFF64748B),
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type a food name or ask a question...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: _handleSendMessage,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: const Color(0xFFFF5252),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 18),
                      onPressed: () => _handleSendMessage(_textController.text),
                    ),
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