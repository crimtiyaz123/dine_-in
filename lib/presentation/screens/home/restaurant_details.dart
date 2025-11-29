import 'package:flutter/material.dart';
import '../../../models/restaurant_model.dart';
import '../../../models/food_item_model.dart';
import '../../../presentation/widgets/food_item_tile.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailsScreen> createState() => _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  List<FoodItem> _menuItems = [];

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  void _loadMenuItems() {
    // Load menu items for the restaurant
    setState(() {
      _menuItems = [
        FoodItem(
          id: '1',
          name: 'Margherita Pizza',
          description: 'Classic pizza with tomato sauce and cheese',
          price: 12.99,
          imageUrl: 'https://example.com/pizza.jpg',
          category: 'Pizza',
          isAvailable: true,
        ),
        FoodItem(
          id: '2',
          name: 'Pepperoni Pizza',
          description: 'Pizza with pepperoni and cheese',
          price: 14.99,
          imageUrl: 'https://example.com/pepperoni.jpg',
          category: 'Pizza',
          isAvailable: true,
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
      ),
      body: Column(
        children: [
          Image.network(
            widget.restaurant.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurant.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.restaurant.address,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.restaurant.rating.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                return FoodItemTile(
                  name: _menuItems[index].name,
                  description: _menuItems[index].description,
                  price: _menuItems[index].price,
                  imageUrl: _menuItems[index].imageUrl,
                  onTap: () {
                    // Add to cart
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
