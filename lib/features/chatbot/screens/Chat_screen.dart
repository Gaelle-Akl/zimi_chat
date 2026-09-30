import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/theme/app_colors.dart';
import '../providers/cart_provider.dart';
import '../providers/chat_provider.dart';
import '../providers/language_provider.dart';
import '../providers/user_preferences_provider.dart';
import '../widgets/ai_message_bubble.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/quick_actions.dart';
import '../widgets/user_message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showQuickActions = true;

  @override
  void dispose() {
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

  void _sendMessage(BuildContext context, String text) {
    if (text.trim().isEmpty) return;

    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final prefsProvider = Provider.of<UserPreferencesProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);

    chatProvider.sendMessage(text, prefsProvider, cartProvider, langProvider);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                // 1. Header
                ChatHeader(
                  onRefresh: () {
                    final cart = Provider.of<CartProvider>(context, listen: false);
                    cart.resetOrder();
                    cart.clearCart();
                    Provider.of<ChatProvider>(context, listen: false).clearMessages(cart, langProvider.currentLanguage);
                  },
                ),

                // 2. Dietary Filter Bar
                Consumer<UserPreferencesProvider>(
                  builder: (context, prefs, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            FilterChip(
                              label: Text(langProvider.translate('filter_vegan')),
                              selected: prefs.isVegan,
                              onSelected: (_) {
                                prefs.toggleVegan();
                                Provider.of<ChatProvider>(context, listen: false)
                                    .updateFilterResults(prefs, Provider.of<CartProvider>(context, listen: false), langProvider);
                              },
                            ),
                            const SizedBox(width: 8),
                            FilterChip(
                              label: Text(langProvider.translate('filter_gluten_free')),
                              selected: prefs.isGlutenFree,
                              onSelected: (_) {
                                prefs.toggleGlutenFree();
                                Provider.of<ChatProvider>(context, listen: false)
                                    .updateFilterResults(prefs, Provider.of<CartProvider>(context, listen: false), langProvider);
                              },
                            ),
                            const SizedBox(width: 8),
                            FilterChip(
                              label: Text(langProvider.translate('filter_dairy_free')),
                              selected: prefs.isDairyFree,
                              onSelected: (_) {
                                prefs.toggleDairyFree();
                                Provider.of<ChatProvider>(context, listen: false)
                                    .updateFilterResults(prefs, Provider.of<CartProvider>(context, listen: false), langProvider);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // 3. Chat Messages List
                Expanded(
                  child: Consumer<ChatProvider>(
                    builder: (context, chatProvider, child) {
                      final messages = chatProvider.messages;
                      _scrollToBottom();

                      return ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: message.isUser
                                ? UserMessageBubble(message: message.text)
                                : AiMessageBubble(message: message),
                          );
                        },
                      );
                    },
                  ),
                ),

                // 4. Floating Cart Summary & Checkout Banner
                Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    if (cart.totalItemCount == 0) return const SizedBox.shrink();

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4745),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF4745).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${cart.totalItemCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                langProvider.translate('cart_total'),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '\$${cart.totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFFFF4745),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              cart.checkout();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${langProvider.translate('order_placed_success')} #${cart.activeOrderId}'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            child: Text(
                              langProvider.translate('checkout'),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // 5. Toggleable Quick Actions Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _showQuickActions = !_showQuickActions;
                          });
                        },
                        icon: Icon(_showQuickActions ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                        label: Text(
                          _showQuickActions
                              ? langProvider.translate('hide_options')
                              : langProvider.translate('show_options'),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_showQuickActions)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: QuickActions(
                      onFindFood: () => _sendMessage(context, langProvider.translate('prompt_find_food')),
                      onTrackOrder: () => _sendMessage(context, langProvider.translate('prompt_track_order')),
                      onPopular: () => _sendMessage(context, langProvider.translate('prompt_popular')),
                      onDeals: () => _sendMessage(context, langProvider.translate('prompt_deals')),
                      onHelp: () => _sendMessage(context, langProvider.translate('prompt_help')),
                    ),
                  ),

                // 6. Input Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: ChatInputBar(
                    onSend: (msg) => _sendMessage(context, msg),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}