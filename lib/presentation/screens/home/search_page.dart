import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dine_in/presentation/screens/restaurant/restaurant_detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  String selectedFilter = "All";
  RangeValues priceRange = const RangeValues(0, 1000);
  double selectedRating = 0.0;
  String selectedDeliveryTime = "Any";
  
  final List<String> cuisineTypes = [
    "All", "Indian", "Chinese", "Italian", "Mexican", "Continental", "Fast Food", "Desserts"
  ];
  
  final List<String> deliveryTimeOptions = [
    "Any", "15 mins", "30 mins", "45 mins", "60 mins"
  ];

  final List<Map<String, dynamic>> allRestaurants = [
    {
      "name": "Royal Biryani House",
      "rating": "4.6",
      "time": "30 mins",
      "cuisine": "Indian",
      "image": "images/biryani.png",
      "minPrice": 200,
      "deliveryTime": 30,
    },
    {
      "name": "Pizza Club",
      "rating": "4.4",
      "time": "25 mins",
      "cuisine": "Italian",
      "image": "images/pizza_club.png",
      "minPrice": 180,
      "deliveryTime": 25,
    },
    {
      "name": "Coffee Corner",
      "rating": "4.8",
      "time": "20 mins",
      "cuisine": "Continental",
      "image": "images/coffee.png",
      "minPrice": 150,
      "deliveryTime": 20,
    },
    {
      "name": "Burger Joint",
      "rating": "4.2",
      "time": "35 mins",
      "cuisine": "Fast Food",
      "image": "images/burger.png",
      "minPrice": 120,
      "deliveryTime": 35,
    },
    {
      "name": "Spice Garden",
      "rating": "4.5",
      "time": "40 mins",
      "cuisine": "Indian",
      "image": "images/maggi.png",
      "minPrice": 220,
      "deliveryTime": 40,
    },
    {
      "name": "Dragon Palace",
      "rating": "4.1",
      "time": "30 mins",
      "cuisine": "Chinese",
      "image": "images/chinese.png",
      "minPrice": 160,
      "deliveryTime": 30,
    },
  ];

  List<Map<String, dynamic>> get filteredRestaurants {
    List<Map<String, dynamic>> filtered = List.from(allRestaurants);
    
    // Filter by search query
    if (searchController.text.isNotEmpty) {
      filtered = filtered.where((restaurant) {
        return restaurant["name"].toString().toLowerCase().contains(
          searchController.text.toLowerCase(),
        ) || restaurant["cuisine"].toString().toLowerCase().contains(
          searchController.text.toLowerCase(),
        );
      }).toList();
    }
    
    // Filter by cuisine
    if (selectedFilter != "All") {
      filtered = filtered.where((restaurant) {
        return restaurant["cuisine"] == selectedFilter;
      }).toList();
    }
    
    // Filter by price range
    filtered = filtered.where((restaurant) {
      return restaurant["minPrice"] >= priceRange.start && 
             restaurant["minPrice"] <= priceRange.end;
    }).toList();
    
    // Filter by rating
    if (selectedRating > 0) {
      filtered = filtered.where((restaurant) {
        return double.parse(restaurant["rating"]) >= selectedRating;
      }).toList();
    }
    
    // Filter by delivery time
    if (selectedDeliveryTime != "Any") {
      int maxTime = int.parse(selectedDeliveryTime.split(' ')[0]);
      filtered = filtered.where((restaurant) {
        return restaurant["deliveryTime"] <= maxTime;
      }).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Search Restaurants',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterSection(),
          Expanded(
            child: filteredRestaurants.isEmpty
                ? _buildEmptyState()
                : _buildRestaurantList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search for restaurants or cuisines...",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _showFilterBottomSheet(),
          ),
        ),
        onChanged: (value) => setState(() {}),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cuisineTypes.length,
        itemBuilder: (context, index) {
          final cuisine = cuisineTypes[index];
          final isSelected = selectedFilter == cuisine;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = cuisine;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  cuisine,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRestaurantList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredRestaurants.length,
      itemBuilder: (context, index) {
        final restaurant = filteredRestaurants[index];
        return _buildRestaurantCard(restaurant);
      },
    );
  }

  Widget _buildRestaurantCard(Map<String, dynamic> restaurant) {
    return GestureDetector(
      onTap: () => _navigateToDetail(restaurant),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(
                restaurant["image"],
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.restaurant, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant["name"],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          restaurant["rating"],
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.access_time, size: 16, color: Colors.green),
                        const SizedBox(width: 4),
                        Text(
                          restaurant["time"],
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      restaurant["cuisine"],
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Min order ₹${restaurant["minPrice"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No restaurants found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your search criteria',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filters',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Price Range Filter
                Text(
                  'Price Range',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                RangeSlider(
                  values: priceRange,
                  min: 0,
                  max: 1000,
                  divisions: 20,
                  activeColor: Colors.green,
                  labels: RangeLabels(
                    '₹${priceRange.start.toInt()}',
                    '₹${priceRange.end.toInt()}',
                  ),
                  onChanged: (values) {
                    setState(() {
                      priceRange = values;
                    });
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Rating Filter
                Text(
                  'Minimum Rating',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Slider(
                  value: selectedRating,
                  min: 0,
                  max: 5,
                  divisions: 10,
                  activeColor: Colors.green,
                  label: selectedRating == 0 ? 'Any' : '${selectedRating.toStringAsFixed(1)}+',
                  onChanged: (value) {
                    setState(() {
                      selectedRating = value;
                    });
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Delivery Time Filter
                Text(
                  'Delivery Time',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: deliveryTimeOptions.map((time) {
                    final isSelected = selectedDeliveryTime == time;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDeliveryTime = time;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                const Spacer(),
                
                // Apply Filters Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(Map<String, dynamic> restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetailPage(
          restaurantName: restaurant["name"],
          rating: restaurant["rating"],
          deliveryTime: restaurant["time"],
          cuisine: restaurant["cuisine"],
          imagePath: restaurant["image"],
        ),
      ),
    );
  }
}