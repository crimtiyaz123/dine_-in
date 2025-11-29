import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dine_in/presentation/screens/orders/order.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String restaurantName;
  final String rating;
  final String deliveryTime;
  final String cuisine;
  final String imagePath;

  const RestaurantDetailPage({
    super.key,
    required this.restaurantName,
    required this.rating,
    required this.deliveryTime,
    required this.cuisine,
    required this.imagePath,
  });

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String selectedCategory = "Popular";
  String orderType = "delivery"; // "delivery" or "dine_in"
  
  final List<Map<String, dynamic>> menuCategories = [
    {"name": "Popular", "icon": Icons.star},
    {"name": "Biryani", "icon": Icons.rice_bowl},
    {"name": "Pizza", "icon": Icons.local_pizza},
    {"name": "Burgers", "icon": Icons.fastfood},
    {"name": "Chinese", "icon": Icons.restaurant},
    {"name": "Beverages", "icon": Icons.local_drink},
    {"name": "Desserts", "icon": Icons.cake},
  ];

  final Map<String, List<Map<String, dynamic>>> menuItems = {
    "Popular": [
      {
        "id": "1",
        "name": "Chicken Biryani",
        "description": "Aromatic basmati rice cooked with tender chicken pieces and authentic spices",
        "price": 250.0,
        "image": "images/biryani.png",
        "rating": 4.6,
        "isVeg": false,
      },
      {
        "id": "2", 
        "name": "Mutton Biryani",
        "description": "Rich and flavorful biryani made with tender mutton and basmati rice",
        "price": 320.0,
        "image": "images/biryani.png",
        "rating": 4.8,
        "isVeg": false,
      },
      {
        "id": "3",
        "name": "Paneer Tikka",
        "description": "Grilled paneer marinated in yogurt and spices, served with mint chutney",
        "price": 180.0,
        "image": "images/desserts.png",
        "rating": 4.5,
        "isVeg": true,
      },
    ],
    "Biryani": [
      {
        "id": "1",
        "name": "Chicken Biryani",
        "description": "Aromatic basmati rice cooked with tender chicken pieces and authentic spices",
        "price": 250.0,
        "image": "images/biryani.png",
        "rating": 4.6,
        "isVeg": false,
      },
      {
        "id": "2",
        "name": "Mutton Biryani", 
        "description": "Rich and flavorful biryani made with tender mutton and basmati rice",
        "price": 320.0,
        "image": "images/biryani.png",
        "rating": 4.8,
        "isVeg": false,
      },
      {
        "id": "4",
        "name": "Vegetable Biryani",
        "description": "Mixed vegetables cooked with basmati rice and fragrant spices",
        "price": 180.0,
        "image": "images/biryani.png",
        "rating": 4.3,
        "isVeg": true,
      },
    ],
    "Pizza": [
      {
        "id": "5",
        "name": "Margherita Pizza",
        "description": "Classic pizza with tomato sauce, mozzarella cheese, and fresh basil",
        "price": 280.0,
        "image": "images/pizza.png",
        "rating": 4.4,
        "isVeg": true,
      },
      {
        "id": "6",
        "name": "Pepperoni Pizza",
        "description": "Delicious pizza topped with pepperoni and melted cheese",
        "price": 350.0,
        "image": "images/pizza.png",
        "rating": 4.6,
        "isVeg": false,
      },
      {
        "id": "7",
        "name": "Veggie Supreme",
        "description": "Pizza loaded with bell peppers, olives, onions, and cheese",
        "price": 320.0,
        "image": "images/pizza.png",
        "rating": 4.2,
        "isVeg": true,
      },
    ],
    "Burgers": [
      {
        "id": "8",
        "name": "Classic Beef Burger",
        "description": "Juicy beef patty with lettuce, tomato, cheese, and special sauce",
        "price": 220.0,
        "image": "images/burger.png",
        "rating": 4.5,
        "isVeg": false,
      },
      {
        "id": "9",
        "name": "Crispy Chicken Burger",
        "description": "Crispy fried chicken breast with mayo and pickles",
        "price": 200.0,
        "image": "images/burger.png",
        "rating": 4.3,
        "isVeg": false,
      },
      {
        "id": "10",
        "name": "Veggie Burger",
        "description": "Plant-based patty with fresh vegetables and sauce",
        "price": 180.0,
        "image": "images/burger.png",
        "rating": 4.1,
        "isVeg": true,
      },
    ],
    "Chinese": [
      {
        "id": "11",
        "name": "Chicken Fried Rice",
        "description": "Stir-fried rice with chicken pieces and vegetables",
        "price": 160.0,
        "image": "images/chinese.png",
        "rating": 4.2,
        "isVeg": false,
      },
      {
        "id": "12",
        "name": "Vegetable Noodles",
        "description": "Soft noodles stir-fried with mixed vegetables",
        "price": 140.0,
        "image": "images/chinese.png",
        "rating": 4.0,
        "isVeg": true,
      },
    ],
    "Beverages": [
      {
        "id": "13",
        "name": "Fresh Lime Soda",
        "description": "Refreshing lime drink with soda water",
        "price": 50.0,
        "image": "images/tea.png",
        "rating": 4.1,
        "isVeg": true,
      },
      {
        "id": "14",
        "name": "Mango Shake",
        "description": "Creamy mango milkshake with rich flavor",
        "price": 80.0,
        "image": "images/coffee.png",
        "rating": 4.4,
        "isVeg": true,
      },
    ],
    "Desserts": [
      {
        "id": "15",
        "name": "Gulab Jamun",
        "description": "Soft milk dumplings in sugar syrup",
        "price": 60.0,
        "image": "images/desserts.png",
        "rating": 4.5,
        "isVeg": true,
      },
      {
        "id": "16",
        "name": "Chocolate Brownie",
        "description": "Rich chocolate brownie with ice cream",
        "price": 120.0,
        "image": "images/desserts.png",
        "rating": 4.6,
        "isVeg": true,
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: menuCategories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: _buildRestaurantInfo(),
          ),
          _buildCategoryTabs(),
          _buildMenuItems(),
        ],
      ),
      floatingActionButton: _buildCartFab(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 250,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.restaurantName,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.restaurant, size: 80, color: Colors.grey),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Added to favorites!')),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Restaurant shared!')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRestaurantInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      widget.rating,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_time, color: Colors.green, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      widget.deliveryTime,
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    widget.cuisine,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Authentic ${widget.cuisine} cuisine with fresh ingredients and traditional recipes. Experience the true taste with every bite.",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          _buildOrderTypeSelection(),
        ],
      ),
    );
  }

  Widget _buildOrderTypeSelection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Choose Order Type",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      orderType = "delivery";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      color: orderType == "delivery" ? Colors.green : Colors.white,
                      border: Border.all(
                        color: orderType == "delivery" ? Colors.green : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delivery_dining,
                          color: orderType == "delivery" ? Colors.white : Colors.grey.shade600,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Delivery",
                          style: GoogleFonts.poppins(
                            color: orderType == "delivery" ? Colors.white : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      orderType = "dine_in";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      color: orderType == "dine_in" ? Colors.green : Colors.white,
                      border: Border.all(
                        color: orderType == "dine_in" ? Colors.green : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant,
                          color: orderType == "dine_in" ? Colors.white : Colors.grey.shade600,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Dine In",
                          style: GoogleFonts.poppins(
                            color: orderType == "dine_in" ? Colors.white : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SliverToBoxAdapter(
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: menuCategories.length,
          itemBuilder: (context, index) {
            final category = menuCategories[index];
            final isSelected = selectedCategory == category["name"];
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category["name"];
                });
                _tabController.animateTo(index);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category["icon"],
                      size: 16,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category["name"],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? Colors.white : Colors.grey,
                      ),
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

  Widget _buildMenuItems() {
    final currentItems = menuItems[selectedCategory] ?? [];
    
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = currentItems[index];
          return _buildMenuItemCard(item);
        },
        childCount: currentItems.length,
      ),
    );
  }

  Widget _buildMenuItemCard(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item["image"],
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 80,
                        width: 80,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.fastfood, color: Colors.grey),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item["name"],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: item["isVeg"] ? Colors.green : Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item["isVeg"] ? "VEG" : "NON-VEG",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item["description"],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, size: 14, color: Colors.amber),
                              const SizedBox(width: 2),
                              Text(
                                item["rating"].toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹${item["price"].toInt()}",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _addToCart(item),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Add",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartFab() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderPage(
              orderType: orderType,
              restaurantName: widget.restaurantName,
            ),
          ),
        );
      },
      backgroundColor: Colors.green,
      icon: const Icon(Icons.shopping_cart, color: Colors.white),
      label: Text(
        orderType == "delivery" ? 'Cart' : 'Table',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      // Adjust FAB position to avoid overlap with curved navigation bar
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
    );
  }

  void _addToCart(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item["name"]} added to cart!'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderPage(
                  orderType: orderType,
                  restaurantName: widget.restaurantName,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}