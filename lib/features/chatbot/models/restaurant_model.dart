class MenuItem {
  final String id;
  final String name;
  final double price;
  final bool isVegan;
  final bool isDairyFree;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.isVegan = false,
    this.isDairyFree = false,
  });
}

class Restaurant {
  final String id;
  final String name;
  final double rating;
  final String imageUrl;
  final String category; // e.g., "pizza", "burger"
  final List<MenuItem> menu;

  Restaurant({
    required this.id,
    required this.name,
    required this.rating,
    required this.imageUrl,
    required this.category,
    required this.menu,
  });
}