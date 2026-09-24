class MenuItem {
  final String id;
  final String name;
  final double price;
  final bool isVegan;
  final bool isDairyFree;
  final bool isGlutenFree;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.isVegan = false,
    this.isDairyFree = false,
    this.isGlutenFree = false,
  });
}

class Restaurant {
  final String id;
  final String name;
  final double rating;
  final String category;
  final String imageUrl;
  final List<MenuItem> menu;

  Restaurant({
    required this.id,
    required this.name,
    required this.rating,
    required this.category,
    required this.imageUrl,
    required this.menu,
  });
}