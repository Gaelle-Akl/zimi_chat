import '../models/restaurant_model.dart';

final List<Restaurant> mockRestaurants = [
  // ---------------- CATEGORY 1: PIZZA ----------------
  Restaurant(
    id: 'rest_1',
    name: 'Tavolina',
    rating: 4.7,
    category: 'pizza',
    imageUrl: 'https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?auto=compress&cs=tinysrgb&w=500',
    menu: [
      MenuItem(
        id: 'tav_1',
        name: 'Margherita Wood-Fired',
        price: 11.00,
        isVegan: false,
        isDairyFree: false,
      ),
      MenuItem(
        id: 'tav_2',
        name: 'Marinara Special',
        price: 9.50,
        isVegan: true,
        isDairyFree: false,
      ),
      MenuItem(
        id: 'tav_3',
        name: 'Dairy-Free Truffle Pizza',
        price: 14.00,
        isVegan: false,
        isDairyFree: true,
      ),
    ],
  ),
  Restaurant(
    id: 'rest_2',
    name: 'Appetito Trattoria',
    rating: 4.6,
    category: 'pizza',
    imageUrl: 'https://images.pexels.com/photos/1146760/pexels-photo-1146760.jpeg?auto=compress&cs=tinysrgb&w=500',
    menu: [
      MenuItem(
        id: 'app_1',
        name: 'Pepperoni Classic',
        price: 12.50,
        isVegan: false,
        isDairyFree: false,
      ),
      MenuItem(
        id: 'app_2',
        name: 'Plant-Based Veggie Feast',
        price: 10.50,
        isVegan: true,
        isDairyFree: false,
      ),
      MenuItem(
        id: 'app_3',
        name: 'Lactose-Free Mushroom Pizza',
        price: 13.00,
        isVegan: false,
        isDairyFree: true,
      ),
    ],
  ),

  // ---------------- CATEGORY 2: BURGERS ----------------
  Restaurant(
    id: 'rest_3',
    name: 'Classic Burger Joint',
    rating: 4.5,
    category: 'burger',
    imageUrl: 'https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg?auto=compress&cs=tinysrgb&w=500',
    menu: [
      MenuItem(
        id: 'cbj_1',
        name: 'Original Cheese Burger',
        price: 8.50,
        isVegan: false,
        isDairyFree: false,
      ),
      MenuItem(
        id: 'cbj_2',
        name: 'Beyond Vegan Patty Burger',
        price: 10.00,
        isVegan: true,
        isDairyFree: false,
      ),
      MenuItem(
        id: 'cbj_3',
        name: 'Dairy-Free BBQ Steak Burger',
        price: 9.50,
        isVegan: false,
        isDairyFree: true,
      ),
    ],
  ),
  Restaurant(
    id: 'rest_4',
    name: 'Husky Burger',
    rating: 4.8,
    category: 'burger',
    imageUrl: 'https://images.pexels.com/photos/1199957/pexels-photo-1199957.jpeg?auto=compress&cs=tinysrgb&w=500',
    menu: [
      MenuItem(
        id: 'hsk_1',
        name: 'Double Bacon Smash Burger',
        price: 11.00,
        isVegan: false,
        isDairyFree: false,
      ),
      MenuItem(
        id: 'hsk_2',
        name: 'Vegan Mushroom Crunch',
        price: 9.00,
        isVegan: true,
        isDairyFree: false,
      ),
      MenuItem(
        id: 'hsk_3',
        name: 'Lactose-Free Chicken Crisp',
        price: 8.50,
        isVegan: false,
        isDairyFree: true,
      ),
    ],
  ),

  // ---------------- CATEGORY 3: ICE CREAM ----------------
  Restaurant(
    id: 'rest_5',
    name: 'Oslo Ice Cream',
    rating: 4.9,
    category: 'ice cream',
    imageUrl: 'https://images.pexels.com/photos/1362534/pexels-photo-1362534.jpeg?auto=compress&cs=tinysrgb&w=500',
    menu: [
      MenuItem(
        id: 'oslo_1',
        name: 'Salted Caramel Cream',
        price: 4.50,
        isVegan: false,
        isDairyFree: false,
      ),
      MenuItem(
        id: 'oslo_2',
        name: 'Dark Chocolate Sorbet (Vegan)',
        price: 5.00,
        isVegan: true,
        isDairyFree: false,
      ),
      MenuItem(
        id: 'oslo_3',
        name: 'Almond Milk Vanilla (Dairy-Free)',
        price: 4.50,
        isVegan: false,
        isDairyFree: true,
      ),
    ],
  ),
  Restaurant(
    id: 'rest_6',
    name: 'Bachir Ice Cream',
    rating: 4.7,
    category: 'ice cream',
    imageUrl: 'https://images.pexels.com/photos/1352278/pexels-photo-1352278.jpeg?auto=compress&cs=tinysrgb&w=500',
    menu: [
      MenuItem(
        id: 'bach_1',
        name: 'Ashta with Pistachio',
        price: 4.00,
        isVegan: false,
        isDairyFree: false,
      ),
      MenuItem(
        id: 'bach_2',
        name: 'Fresh Strawberry Fruit Ice',
        price: 3.50,
        isVegan: true,
        isDairyFree: false,
      ),
      MenuItem(
        id: 'bach_3',
        name: 'Coconut Milk Scoop',
        price: 4.00,
        isVegan: false,
        isDairyFree: true,
      ),
    ],
  ),
];