import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/custom_button.dart';

class AssignDriverPage extends StatefulWidget {
  const AssignDriverPage({super.key});

  @override
  State<AssignDriverPage> createState() => _AssignDriverPageState();
}

class _AssignDriverPageState extends State<AssignDriverPage> {
  String? _selectedDriverId;
  late String _orderId;

  final List<Map<String, dynamic>> _availableDrivers = [
    {
      'id': 'D001',
      'name': 'John Smith',
      'phone': '+91 9876543210',
      'rating': 4.8,
      'status': 'Available',
      'vehicle': 'Bike',
    },
    {
      'id': 'D002',
      'name': 'Mike Johnson',
      'phone': '+91 9876543211',
      'rating': 4.6,
      'status': 'Available',
      'vehicle': 'Scooter',
    },
    {
      'id': 'D003',
      'name': 'Sarah Wilson',
      'phone': '+91 9876543212',
      'rating': 4.9,
      'status': 'Available',
      'vehicle': 'Bike',
    },
    {
      'id': 'D004',
      'name': 'David Brown',
      'phone': '+91 9876543213',
      'rating': 4.7,
      'status': 'Busy',
      'vehicle': 'Car',
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the orderId from route arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      _orderId = args;
    } else {
      _orderId = 'Unknown';
    }
  }

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
          'Assign Driver',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Text(
              'Order #$_orderId - Select a driver to assign',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _availableDrivers.length,
              itemBuilder: (context, index) {
                final driver = _availableDrivers[index];
                final isSelected = _selectedDriverId == driver['id'];
                final isAvailable = driver['status'] == 'Available';

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey.shade200,
                      width: isSelected ? 2 : 1,
                    ),
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
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  driver['name'],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.phone, size: 14, color: Colors.grey.shade600),
                                    const SizedBox(width: 4),
                                    Text(
                                      driver['phone'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isAvailable)
                            Radio<String>(
                              value: driver['id'],
                              groupValue: _selectedDriverId,
                              onChanged: (value) {
                                setState(() {
                                  _selectedDriverId = value;
                                });
                              },
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isAvailable ? Colors.green.shade100 : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              driver['status'],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: isAvailable ? Colors.green.shade800 : Colors.red.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Row(
                            children: [
                              Icon(Icons.star, size: 14, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                '${driver['rating']}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Row(
                            children: [
                              Icon(Icons.directions_car, size: 14, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                driver['vehicle'],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
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
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: CustomButton(
              text: 'Assign Driver',
              onPressed: _selectedDriverId != null ? _assignDriver : () {},
              backgroundColor: _selectedDriverId != null ? Colors.blue : Colors.grey,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _assignDriver() {
    // Here you would typically make an API call to assign the driver
    // For now, we'll just show a success message and go back
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Driver assigned successfully to Order #$_orderId',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.green,
      ),
    );

    // Go back to the previous screen
    Navigator.pop(context);
  }
}
