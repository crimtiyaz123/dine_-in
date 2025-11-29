import 'package:flutter/material.dart';

class RestaurantDetailsPage extends StatefulWidget {
  const RestaurantDetailsPage({super.key});

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage>
    with TickerProviderStateMixin {
  
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("View Cart"),
        icon: const Icon(Icons.shopping_cart),
        backgroundColor: const Color(0xFF07ED9D),
      ),
      body: Column(
        children: [
          // Top Section
          Stack(
            children: [
              Image.network(
                "https://i.postimg.cc/3JjFk8Pp/food-banner.jpg",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 10,
                top: 40,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              )
            ],
          ),

          // Restaurant Info
          ListTile(
            title: const Text("Bistro Cafe",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            subtitle: const Text("Fast Food · 1.5 km"),
            trailing: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.white, size: 18),
                  SizedBox(width: 5),
                  Text("4.5",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          // Tabs
          TabBar(
            controller: tabController,
            labelColor: Colors.black,
            indicatorColor: Colors.green,
            tabs: const [
              Tab(text: "Menu"),
              Tab(text: "Reviews"),
              Tab(text: "Info"),
            ],
          ),

          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                menuSection(),
                const Center(child: Text("No Reviews Yet")),
                const Center(child: Text("Timing: 10am - 11pm")),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget menuSection() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://i.postimg.cc/XJ2FCV17/food.jpg",
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text("Item ${index + 1}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: const Text("Delicious food item"),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF07ED9D),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Add"),
            ),
          ),
        );
      },
    );
  }
}
