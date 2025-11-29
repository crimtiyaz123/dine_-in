import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderReportsPage extends StatefulWidget {
  const OrderReportsPage({super.key});

  @override
  State<OrderReportsPage> createState() => _OrderReportsPageState();
}

class _OrderReportsPageState extends State<OrderReportsPage> {
  String _selectedPeriod = 'Today';

  final List<Map<String, dynamic>> _orderReports = [
    {
      'id': 'ORD-001',
      'customer': 'John Doe',
      'items': ['Chicken Biryani', 'Raita'],
      'total': 210,
      'status': 'Completed',
      'time': '2:30 PM',
      'paymentMethod': 'UPI',
    },
    {
      'id': 'ORD-002',
      'customer': 'Jane Smith',
      'items': ['Paneer Butter Masala', 'Naan'],
      'total': 280,
      'status': 'Completed',
      'time': '1:15 PM',
      'paymentMethod': 'Cash',
    },
    {
      'id': 'ORD-003',
      'customer': 'Mike Johnson',
      'items': ['Margherita Pizza', 'Coke'],
      'total': 220,
      'status': 'Cancelled',
      'time': '12:45 PM',
      'paymentMethod': 'Card',
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
          'Order Reports',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Period selector and filters
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter by Period',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.green),
                      onPressed: () {
                        // Show filter options
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: ['Today', 'This Week', 'This Month', 'Custom'].map((period) {
                    final isSelected = _selectedPeriod == period;
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(
                          period,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedPeriod = period);
                          }
                        },
                        backgroundColor: Colors.grey.shade100,
                        selectedColor: Colors.green,
                        checkmarkColor: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Order summary stats
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Total Orders', '23', Colors.blue),
                _buildStatItem('Completed', '21', Colors.green),
                _buildStatItem('Cancelled', '2', Colors.red),
                _buildStatItem('Revenue', '₹4,850', Colors.purple),
              ],
            ),
          ),

          // Orders list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _orderReports.length,
              itemBuilder: (context, index) {
                final order = _orderReports[index];
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            order['id'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black,
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

                      const SizedBox(height: 8),

                      // Customer and time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, size: 16, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                order['customer'],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                order['time'],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Items
                      Text(
                        'Items: ${order['items'].join(', ')}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // Total and payment method
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
                          Row(
                            children: [
                              Icon(
                                _getPaymentIcon(order['paymentMethod']),
                                size: 16,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                order['paymentMethod'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getPaymentIcon(String method) {
    switch (method) {
      case 'UPI':
        return Icons.payment;
      case 'Cash':
        return Icons.money;
      case 'Card':
        return Icons.credit_card;
      default:
        return Icons.payment;
    }
  }
}
