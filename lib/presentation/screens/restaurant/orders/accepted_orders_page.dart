import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/custom_button.dart';

class AcceptedOrdersPage extends StatefulWidget {
  const AcceptedOrdersPage({super.key});

  @override
  State<AcceptedOrdersPage> createState() => _AcceptedOrdersPageState();
}

class _AcceptedOrdersPageState extends State<AcceptedOrdersPage> {
  final List<Map<String, dynamic>> _acceptedOrders = [
    {
      'id': '1232',
      'customer': 'Mike Johnson',
      'phone': '+91 9876543212',
      'items': [
        {'name': 'Butter Chicken', 'quantity': 1, 'price': 220},
        {'name': 'Naan', 'quantity': 2, 'price': 50},
      ],
      'total': 320,
      'status': 'Preparing',
      'estimatedTime': '15-20 mins',
      'orderTime': '15 mins ago',
    },
    {
      'id': '1233',
      'customer': 'Sarah Wilson',
      'phone': '+91 9876543213',
      'items': [
        {'name': 'Paneer Tikka', 'quantity': 1, 'price': 180},
        {'name': 'Salad', 'quantity': 1, 'price': 50},
      ],
      'total': 230,
      'status': 'Ready for Pickup',
      'estimatedTime': 'Ready',
      'orderTime': '25 mins ago',
    },
  ];

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
          'Accepted Orders',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _acceptedOrders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No accepted orders',
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
              itemCount: _acceptedOrders.length,
              itemBuilder: (context, index) {
                final order = _acceptedOrders[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
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
                      // Order header
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
                              color: _getStatusColor(order['status']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              order['status'].toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: _getStatusColor(order['status']),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Customer info
                      Row(
                        children: [
                          Icon(Icons.person, size: 16, color: Colors.grey.shade600),
                          const SizedBox(width: 8),
                          Text(
                            order['customer'],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Row(
                        children: [
                          Icon(Icons.phone, size: 16, color: Colors.grey.shade600),
                          const SizedBox(width: 8),
                          Text(
                            order['phone'],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Order items summary
                      Text(
                        'Items: ${order['items'].length} item(s)',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Total and time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: ₹${order['total']}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                order['estimatedTime'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                order['orderTime'],
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Action buttons
                      if (order['status'] == 'Preparing')
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: 'Mark as Ready',
                                onPressed: () => _markAsReady(order['id']),
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        )
                      else if (order['status'] == 'Ready for Pickup')
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: 'Assign Driver',
                                onPressed: () => _assignDriver(order['id']),
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Preparing':
        return Colors.orange;
      case 'Ready for Pickup':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _markAsReady(String orderId) {
    setState(() {
      final orderIndex = _acceptedOrders.indexWhere((order) => order['id'] == orderId);
      if (orderIndex != -1) {
        _acceptedOrders[orderIndex]['status'] = 'Ready for Pickup';
        _acceptedOrders[orderIndex]['estimatedTime'] = 'Ready';
      }
    });
  }

  void _assignDriver(String orderId) {
    // Navigate to assign driver page
    Navigator.pushNamed(context, '/restaurant/assign-driver', arguments: orderId);
  }
}
