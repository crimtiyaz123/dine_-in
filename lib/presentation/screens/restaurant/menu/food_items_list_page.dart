import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodItemsListPage extends StatefulWidget {
  const FoodItemsListPage({super.key});

  @override
  State<FoodItemsListPage> createState() => _FoodItemsListPageState();
}

class _FoodItemsListPageState extends State<FoodItemsListPage> {
  String _categoryName = 'Main Course'; // Would come from route arguments
  final List<Map<String, dynamic>> _foodItems = [
    {
      'id': '1',
      'name': 'Chicken Biryani',
      'description': 'Aromatic basmati rice with tender chicken pieces',
      'price': 180,
      'image': 'images/biryani.png',
      'isAvailable': true,
      'preparationTime': '25-30 mins',
    },
    {
      'id': '2',
      'name': 'Paneer Butter Masala',
      'description': 'Creamy tomato curry with soft paneer cubes',
      'price': 160,
      'image': 'images/paneer.png',
      'isAvailable': true,
      'preparationTime': '15-20 mins',
    },
    {
      'id': '3',
      'name': 'Margherita Pizza',
      'description': 'Classic pizza with tomato sauce, mozzarella and basil',
      'price': 150,
      'image': 'images/pizza.png',
      'isAvailable': false,
      'preparationTime': '20-25 mins',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get category name from route arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is String) {
      _categoryName = arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _categoryName,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Navigate to search page
            },
          ),
        ],
      ),
      body: _foodItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No items in this category',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Add your first food item',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _foodItems.length,
              itemBuilder: (context, index) {
                final item = _foodItems[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Food Image
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.restaurant,
                                color: Colors.grey.shade400,
                                size: 30,
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Item Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item['name'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                // Availability Toggle
                                Switch(
                                  value: item['isAvailable'],
                                  onChanged: (value) => _toggleAvailability(item['id'], value),
                                  activeColor: Colors.green,
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            Text(
                              item['description'],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Text(
                                  '₹${item['price']}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: Colors.grey.shade500,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  item['preparationTime'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Edit Button
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () => _editItem(item['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _addItem,
      ),
    );
  }

  void _toggleAvailability(String itemId, bool isAvailable) {
    setState(() {
      final itemIndex = _foodItems.indexWhere((item) => item['id'] == itemId);
      if (itemIndex != -1) {
        _foodItems[itemIndex]['isAvailable'] = isAvailable;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isAvailable ? 'Item is now available' : 'Item is now unavailable',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: isAvailable ? Colors.green : Colors.orange,
      ),
    );
  }

  void _editItem(String itemId) {
    // Navigate to edit food item page
    Navigator.pushNamed(context, '/restaurant/edit-food-item', arguments: itemId);
  }

  void _addItem() {
    // Navigate to add food item page
    Navigator.pushNamed(context, '/restaurant/add-food-item', arguments: _categoryName);
  }
}
