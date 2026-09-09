import '../models/restaurant_model.dart';

final List<Restaurant> mockRestaurants = [
  // ---------------- CATEGORY 1: PIZZA ----------------
  Restaurant(
    id: 'rest_1',
    name: 'Tavolina',
    rating: 4.7,
    category: 'pizza',
    imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=500',
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
    imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500',
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
    imageUrl: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=500',
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
    imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
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
    imageUrl: 'https://images.unsplash.com/photo-1567206563064-6f60f4078b57?w=500',
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
    imageUrl: 'https://images.unsplash.com/photo-1501443762994-82bd5dace89a?w=500',
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