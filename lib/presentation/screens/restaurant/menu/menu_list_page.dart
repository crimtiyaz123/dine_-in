import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuListPage extends StatefulWidget {
  const MenuListPage({super.key});

  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  final List<Map<String, dynamic>> _categories = [
    {
      'id': '1',
      'name': 'Main Course',
      'icon': Icons.restaurant,
      'itemCount': 12,
    },
    {
      'id': '2',
      'name': 'Starters',
      'icon': Icons.fastfood,
      'itemCount': 8,
    },
    {
      'id': '3',
      'name': 'Beverages',
      'icon': Icons.local_drink,
      'itemCount': 6,
    },
    {
      'id': '4',
      'name': 'Desserts',
      'icon': Icons.cake,
      'itemCount': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Menu',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: _buildDrawer(context),
      body: _categories.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu_book,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No categories yet',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
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
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          category['icon'],
                          color: Colors.green,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category['name'],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${category['itemCount']} items',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () => _editCategory(category['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _addCategory,
      ),
    );
  }

  void _editCategory(String categoryId) {
    // Navigate to edit category page
    Navigator.pushNamed(context, '/restaurant/edit-category', arguments: categoryId);
  }

  void _addCategory() {
    // Navigate to add category page
    Navigator.pushNamed(context, '/restaurant/add-category');
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.restaurant, color: Colors.green, size: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  'Restaurant Dashboard',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Manage your restaurant',
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.green),
            title: Text(
              'Dashboard',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/restaurant/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu_book, color: Colors.green),
            title: Text(
              'Menu',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              // Already on menu
            },
          ),
          ListTile(
            leading: const Icon(Icons.restaurant_menu, color: Colors.green),
            title: Text(
              'Food Items',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/restaurant/food-items');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle, color: Colors.green),
            title: Text(
              'Add Category',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/restaurant/add-category');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box, color: Colors.green),
            title: Text(
              'Add Food Item',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/restaurant/add-food-item');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.green),
            title: Text(
              'Business Hours',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/restaurant/business-hours');
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics, color: Colors.green),
            title: Text(
              'Analytics',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/restaurant/analytics');
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: Colors.green),
            title: Text(
              'Payment & Banking',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/restaurant/payment-banking');
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.green),
            title: Text(
              'Help & Support',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/restaurant/support');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(
              'Logout',
              style: GoogleFonts.poppins(color: Colors.red),
            ),
            onTap: () {
              Navigator.pop(context);
              // Implement logout logic
              Navigator.pushReplacementNamed(context, '/restaurant/login');
            },
          ),
        ],
      ),
    );
  }
}
