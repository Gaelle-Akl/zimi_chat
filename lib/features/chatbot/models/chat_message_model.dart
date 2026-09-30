class MenuItemModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String imageUrl;
  final bool isVegan;
  final bool isGlutenFree;
  final bool isDairyFree;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.isVegan = false,
    this.isGlutenFree = false,
    this.isDairyFree = false,
  });
}

class ChatMessageModel {
  final String text;
  final bool isUser;
  final String? timestamp;
  final List<MenuItemModel>? menuItems;

  ChatMessageModel({
    required this.text,
    required this.isUser,
    this.timestamp,
    this.menuItems,
  });
}