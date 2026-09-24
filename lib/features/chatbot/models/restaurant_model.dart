class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final bool isVegan;
  final bool isDairyFree;
  final bool isGlutenFree;

  MenuItem({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    this.imageUrl,
    this.isVegan = false,
    this.isDairyFree = false,
    this.isGlutenFree = false,
  });
}

class Restaurant {
  final String id;
  final String name;
  final String category;
  final double rating;
  final String imageUrl;
  final List<MenuItem> menu;

  Restaurant({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.imageUrl,
    required this.menu,
  });
}