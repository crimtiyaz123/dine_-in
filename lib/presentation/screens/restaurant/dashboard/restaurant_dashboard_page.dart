import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantDashboardPage extends StatelessWidget {
  const RestaurantDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dashboardItems = [
      {
        'title': 'Menu',
        'icon': Icons.menu_book,
        'route': '/restaurant/menu',
        'color': Colors.green,
      },
      {
        'title': 'Orders',
        'icon': Icons.shopping_cart,
        'route': '/restaurant/orders',
        'color': Colors.blue,
      },
      {
        'title': 'Payment & Banking',
        'icon': Icons.payment,
        'route': '/restaurant/payment-banking',
        'color': Colors.orange,
      },
      {
        'title': 'Business Hours',
        'icon': Icons.schedule,
        'route': '/restaurant/business-hours',
        'color': Colors.purple,
      },
      {
        'title': 'Analytics',
        'icon': Icons.analytics,
        'route': '/restaurant/analytics',
        'color': Colors.red,
      },
      {
        'title': 'Help & Support',
        'icon': Icons.help,
        'route': '/restaurant/support',
        'color': Colors.teal,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Restaurant Dashboard',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: dashboardItems.length,
          itemBuilder: (context, index) {
            final item = dashboardItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, item['route']);
              },
              child: Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: item['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item['icon'],
                        size: 30,
                        color: item['color'],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
