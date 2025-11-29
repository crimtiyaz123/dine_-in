import 'package:flutter/material.dart';
import '../screens/home/home.dart';
import '../screens/orders/orders_page.dart';
import '../screens/profile/profile.dart';
import '../../core/widgets/curved_navigation_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const OrdersPage(),
    const ProfilePage(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {
      'icon': Icons.home_outlined,
      'activeIcon': Icons.home,
      'label': 'Home',
    },
    {
      'icon': Icons.shopping_bag_outlined,
      'activeIcon': Icons.shopping_bag,
      'label': 'Orders',
    },
    {
      'icon': Icons.person_outline,
      'activeIcon': Icons.person,
      'label': 'Profile',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.green,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 70,
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navItems.map((item) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _currentIndex == _navItems.indexOf(item) 
                      ? item['activeIcon'] 
                      : item['icon'],
                  size: 22,
                  color: _currentIndex == _navItems.indexOf(item) 
                      ? Colors.green 
                      : Colors.grey.shade600,
                ),
                const SizedBox(height: 2),
                Text(
                  item['label'],
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: _currentIndex == _navItems.indexOf(item) 
                        ? FontWeight.w600 
                        : FontWeight.w400,
                    color: _currentIndex == _navItems.indexOf(item) 
                        ? Colors.green 
                        : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}