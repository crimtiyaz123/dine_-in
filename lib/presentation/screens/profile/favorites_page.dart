import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  // Sample favorites data - in a real app, this would come from a database or API
  final List<Map<String, dynamic>> favoriteItems = [
    {
      'name': 'Pizza Palace',
      'category': 'Italian',
      'rating': 4.5,
      'deliveryTime': '25-30 min',
      'image': '🍕'
    },
    {
      'name': 'Burger Hub',
      'category': 'American',
      'rating': 4.2,
      'deliveryTime': '20-25 min',
      'image': '🍔'
    },
    {
      'name': 'Sushi Express',
      'category': 'Japanese',
      'rating': 4.8,
      'deliveryTime': '30-35 min',
      'image': '🍣'
    },
    {
      'name': 'Taco Fiesta',
      'category': 'Mexican',
      'rating': 4.3,
      'deliveryTime': '15-20 min',
      'image': '🌮'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Favorites"),
      ),
      body: favoriteItems.isEmpty
          ? _buildEmptyState()
          : _buildFavoritesList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            "No favorites yet",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Start adding restaurants to your favorites!",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favoriteItems.length,
      itemBuilder: (context, index) {
        final item = favoriteItems[index];
        return _buildFavoriteCard(item, index);
      },
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> item, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Restaurant Icon/Image
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green.shade100,
              child: Text(
                item['image'],
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(width: 16),
            // Restaurant Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['category'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item['rating'].toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item['deliveryTime'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Remove from Favorites Button
            IconButton(
              onPressed: () => _removeFromFavorites(index),
              icon: Icon(
                Icons.favorite,
                color: Colors.red.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeFromFavorites(int index) {
    setState(() {
      favoriteItems.removeAt(index);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Removed from favorites"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}