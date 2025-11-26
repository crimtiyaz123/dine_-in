import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dine_in/core/services/category_data.dart';
import 'package:dine_in/config/app_colors.dart';
import 'package:dine_in/presentation/screens/orders/order.dart';
import 'package:dine_in/presentation/screens/restaurant/restaurant_detail.dart';
import 'package:dine_in/presentation/screens/home/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentLocation = "Getting location...";
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          currentLocation = "Location services disabled";
        });
        return;
      }

      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || 
          permission == LocationPermission.deniedForever) {
        setState(() {
          currentLocation = "Location permission denied";
        });
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 10),
      );
      
      setState(() {
        currentLocation = "Lat: ${pos.latitude.toStringAsFixed(2)}, Long: ${pos.longitude.toStringAsFixed(2)}";
      });
    } catch (e) {
      setState(() {
        currentLocation = "Location error occurred";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBar(),
            const SizedBox(height: 12),
            _promoBanner(),
            const SizedBox(height: 20),
            _sectionTitle("Categories"),
            const SizedBox(height: 10),
            _categoryList(),
            const SizedBox(height: 10),
            _cartButton(),
            const SizedBox(height: 20),
            _sectionTitle("Popular Restaurants"),
            const SizedBox(height: 10),
            _restaurantCard("Royal Biryani House", "4.6", "30 mins", "images/biryani.png"),
            _restaurantCard("Pizza Club", "4.4", "25 mins", "images/pizza.png"),
            _restaurantCard("Coffee Corner", "4.8", "20 mins", "images/coffee.png"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ---- UI COMPONENTS ----

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const Icon(Icons.location_on, color: Colors.red),
      title: Text(
        currentLocation,
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: Colors.black),
        )
      ],
    );
  }

  Widget _searchBar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchPage()),
        );
      },
      child: AbsorbPointer(
        absorbing: true,
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search food or restaurants",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }

  Widget _promoBanner() {
    final PageController _pageController = PageController();
    int _currentPage = 0;

    final List<Map<String, dynamic>> promoOffers = [
      {
        "title": "50% OFF",
        "subtitle": "on your first order",
        "description": "Use code FIRST50",
        "backgroundColor": Colors.red.shade600,
        "textColor": Colors.white,
      },
    
      {
        "title": "20% OFF",
        "subtitle": "on Chinese cuisine",
        "description": "Valid till midnight",
        "backgroundColor": Colors.orange.shade600,
        "textColor": Colors.white,
      },
    ];

    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: promoOffers.length,
            itemBuilder: (context, index) {
              final offer = promoOffers[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: offer["backgroundColor"],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  offer["title"],
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: offer["textColor"],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  offer["subtitle"],
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: offer["textColor"],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: offer["textColor"].withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    offer["description"],
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      color: offer["textColor"],
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: offer["textColor"].withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.local_offer,
                              size: 20,
                              color: offer["textColor"],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                promoOffers.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  Widget _categoryList() {
    final categories = getCategories();
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final category = categories[index];
          return _categoryItem(
            category.id,
            category.name!,
            category.image!,
          );
        },
      ),
    );
  }

  Widget _categoryItem(String id, String name, String imagePath) {
    final isSelected = selectedCategoryId == id;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedCategoryId == id) {
            selectedCategoryId = null; // Deselect if already selected
          } else {
            selectedCategoryId = id; // Select new category
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isSelected ? 'Deselected $name' : 'Browsing $name items...')),
        );
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected 
                      ? AppColors.categoryBorderSelected 
                      : AppColors.categoryBorderUnselected,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundColor: isSelected 
                    ? AppColors.categorySelected 
                    : AppColors.categoryUnselected,
                child: Image.asset(
                  imagePath,
                  height: 32,
                  width: 32,
                  fit: BoxFit.contain,
                  color: isSelected ? Colors.white : null,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.restaurant, 
                      color: isSelected ? Colors.white : AppColors.categorySelected, 
                      size: 32
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isSelected 
                    ? AppColors.categoryTextSelected 
                    : AppColors.categoryTextUnselected,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrderPage(
                orderType: "delivery",
                restaurantName: "Restaurant",
              ),
            ),
          );
        },
        backgroundColor: Colors.green,
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        label: const Text(
          'Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }



  Widget _restaurantCard(String name, String rating, String time, String img) {
    return GestureDetector(
      onTap: () => _navigateToRestaurantDetail(name, rating, time, img),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(img, height: 80, width: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name, 
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              "$rating • $time", 
                              style: GoogleFonts.poppins(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToRestaurantDetail(String name, String rating, String time, String img) {
    String cuisine = "Multi-Cuisine"; // Default cuisine
    if (name.toLowerCase().contains("biryani")) {
      cuisine = "Indian";
    } else if (name.toLowerCase().contains("pizza")) {
      cuisine = "Italian";
    } else if (name.toLowerCase().contains("coffee")) {
      cuisine = "Continental";
    } else if (name.toLowerCase().contains("burger")) {
      cuisine = "Fast Food";
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetailPage(
          restaurantName: name,
          rating: rating,
          deliveryTime: time,
          cuisine: cuisine,
          imagePath: img,
        ),
      ),
    );
  }
}
