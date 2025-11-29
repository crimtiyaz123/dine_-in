import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersNavigationPage extends StatefulWidget {
  const OrdersNavigationPage({super.key});

  @override
  State<OrdersNavigationPage> createState() => _OrdersNavigationPageState();
}

class _OrdersNavigationPageState extends State<OrdersNavigationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Orders',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),

        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: Colors.green,
          tabs: const [
            Tab(text: 'New'),
            Tab(text: 'Preparing'),
            Tab(text: 'Ready for Pickup'),
            Tab(text: 'Accepted'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList('new'),
          _buildOrdersList('preparing'),
          _buildOrdersList('ready_for_pickup'),
          _buildOrdersList('accepted'),
          _buildOrdersList('completed'),
        ],
      ),
    );
  }

  Widget _buildOrdersList(String type) {
    // Mock data - in real app, this would come from API
    final orders = _getMockOrders(type);

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type == 'new' ? Icons.inbox : Icons.check_circle,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              type == 'new' ? 'No new orders' : 'No $type orders',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return GestureDetector(
          onTap: () {
            if (type == 'new') {
              Navigator.pushNamed(context, '/restaurant/order-details');
            } else if (type == 'accepted') {
              Navigator.pushNamed(context, '/restaurant/accepted-orders');
            } else {
              Navigator.pushNamed(context, '/restaurant/completed-orders');
            }
          },
          child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order #${order['id']}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(type).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        type.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: _getStatusColor(type),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  order['customer'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  order['items'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${order['amount']}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      order['time'],
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
        );
      },
    );
  }

  List<Map<String, dynamic>> _getMockOrders(String type) {
    switch (type) {
      case 'new':
        return [
          {
            'id': '1234',
            'customer': 'John Doe',
            'items': 'Chicken Biryani, Raita',
            'amount': '250',
            'time': '2 mins ago',
          },
          {
            'id': '1235',
            'customer': 'Jane Smith',
            'items': 'Margherita Pizza, Coke',
            'amount': '180',
            'time': '5 mins ago',
          },
        ];
      case 'accepted':
        return [
          {
            'id': '1232',
            'customer': 'Mike Johnson',
            'items': 'Butter Chicken, Naan',
            'amount': '320',
            'time': '15 mins ago',
          },
        ];
      case 'completed':
        return [
          {
            'id': '1230',
            'customer': 'Sarah Wilson',
            'items': 'Paneer Tikka, Salad',
            'amount': '280',
            'time': '1 hour ago',
          },
          {
            'id': '1231',
            'customer': 'David Brown',
            'items': 'Fish Curry, Rice',
            'amount': '350',
            'time': '2 hours ago',
          },
        ];
      default:
        return [];
    }
  }

  Color _getStatusColor(String type) {
    switch (type) {
      case 'new':
        return Colors.blue;
      case 'preparing':
        return Colors.orange;
      case 'ready_for_pickup':
        return Colors.blue;
      case 'accepted':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
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
              // Already on dashboard
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
              Navigator.pushNamed(context, '/restaurant/menu');
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
