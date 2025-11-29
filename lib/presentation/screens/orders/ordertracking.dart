import 'package:flutter/material.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  int currentStep = 2;  // For demo -> (0 to 4) change to test UI

  List<String> steps = [
    "Order Placed",
    "Restaurant Accepted",
    "Preparing Food",
    
    "Delivered",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Track Order"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Estimated Delivery Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: const [
                  Text("Delivery in 20-25 min",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      )),
                  SizedBox(height: 5),
                  Text("Your order is being prepared",
                      style: TextStyle(fontSize: 14, color: Colors.black54)),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Timeline Steps
            Expanded(
              child: ListView.builder(
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  bool isCompleted = index <= currentStep;
                  return Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: isCompleted ? Colors.green : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          if (index != steps.length - 1)
                            Container(
                              width: 2,
                              height: 50,
                              color: isCompleted ? Colors.green : Colors.grey,
                            ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Text(
                        steps[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                          color: isCompleted ? Colors.green : Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Rider Details
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
              ),
             
            ),
          ],
        ),
      ),
    );
  }
}
