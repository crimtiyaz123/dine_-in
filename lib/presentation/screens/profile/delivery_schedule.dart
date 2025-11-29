import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum DeliveryTimeSlot {
  asSoonAsPossible,
  scheduled,
}

class DeliverySchedulePage extends StatefulWidget {
  final double orderAmount;
  
  const DeliverySchedulePage({
    super.key,
    required this.orderAmount,
  });

  @override
  State<DeliverySchedulePage> createState() => _DeliverySchedulePageState();
}

class TimeSlot {
  final String id;
  final String label;
  final String timeRange;
  final bool isAvailable;
  final double deliveryFee;
  final String description;

  TimeSlot({
    required this.id,
    required this.label,
    required this.timeRange,
    required this.isAvailable,
    required this.deliveryFee,
    required this.description,
  });
}

class _DeliverySchedulePageState extends State<DeliverySchedulePage> {
  DeliveryTimeSlot selectedOption = DeliveryTimeSlot.asSoonAsPossible;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedTimeSlotId;

  @override
  void initState() {
    super.initState();
    // Default to current time + 30 minutes for scheduled delivery
    final now = DateTime.now();
    selectedDate = DateTime(now.year, now.month, now.day);
    selectedTime = TimeOfDay.fromDateTime(now.add(const Duration(minutes: 30)));
  }

  List<TimeSlot> get _timeSlots {
    final now = DateTime.now();
    final currentDay = DateTime.now().weekday; // 1 = Monday, 7 = Sunday
    
    return [
      TimeSlot(
        id: "now",
        label: "ASAP",
        timeRange: "30-45 mins",
        isAvailable: true,
        deliveryFee: 0.0,
        description: "Fastest delivery available",
      ),
      TimeSlot(
        id: "30min",
        label: "30 min",
        timeRange: "30 mins from now",
        isAvailable: true,
        deliveryFee: 0.0,
        description: "Quick delivery in 30 minutes",
      ),
      TimeSlot(
        id: "45min",
        label: "45 min",
        timeRange: "45 mins from now", 
        isAvailable: true,
        deliveryFee: 0.0,
        description: "Standard delivery in 45 minutes",
      ),
      TimeSlot(
        id: "1hour",
        label: "1 hour",
        timeRange: "60 mins from now",
        isAvailable: true,
        deliveryFee: 0.0,
        description: "Free delivery in 1 hour",
      ),
      TimeSlot(
        id: "2hour",
        label: "2 hours",
        timeRange: "120 mins from now",
        isAvailable: true,
        deliveryFee: 0.0,
        description: "Save time with scheduled delivery",
      ),
      TimeSlot(
        id: "evening",
        label: "Evening",
        timeRange: "6:00 PM - 8:00 PM",
        isAvailable: currentDay != DateTime.sunday, // Not available on Sundays
        deliveryFee: 0.0,
        description: "Evening slot for busy schedules",
      ),
      TimeSlot(
        id: "late",
        label: "Late Night",
        timeRange: "10:00 PM - 12:00 AM",
        isAvailable: currentDay < DateTime.friday, // Mon-Thu only
        deliveryFee: 0.0,
        description: "Late night cravings?",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Delivery Schedule',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderSummary(),
          _buildDeliveryOptions(),
          Expanded(
            child: _buildTimeSlots(),
          ),
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.shopping_bag, color: Colors.green, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Amount',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${widget.orderAmount.toInt()}',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'When would you like your order?',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildOptionCard(
                  DeliveryTimeSlot.asSoonAsPossible,
                  "ASAP",
                  "Deliver as soon as possible",
                  Icons.timer,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildOptionCard(
                  DeliveryTimeSlot.scheduled,
                  "Schedule",
                  "Choose a specific time",
                  Icons.schedule,
                  Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(DeliveryTimeSlot option, String title, String subtitle, IconData icon, Color color) {
    final isSelected = selectedOption == option;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey.shade600,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? color : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlots() {
    if (selectedOption == DeliveryTimeSlot.asSoonAsPossible) {
      return _buildASAPSection();
    } else {
      return _buildScheduledSection();
    }
  }

  Widget _buildASAPSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_shipping,
            size: 60,
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          Text(
            'Delivery in 30-45 minutes',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Your order will be prepared and delivered as quickly as possible',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'FREE DELIVERY',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Select Delivery Time',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _timeSlots.length,
            itemBuilder: (context, index) {
              final slot = _timeSlots[index];
              return _buildTimeSlotCard(slot);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlotCard(TimeSlot slot) {
    final isSelected = selectedTimeSlotId == slot.id;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: slot.isAvailable ? 2 : 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: slot.isAvailable 
              ? () {
                  setState(() {
                    selectedTimeSlotId = slot.id;
                  });
                }
              : null,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: !slot.isAvailable ? Colors.grey.shade100 : null,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.blue : (slot.isAvailable ? Colors.grey.shade300 : Colors.grey.shade200),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            slot.label,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: slot.isAvailable 
                                  ? (isSelected ? Colors.blue : Colors.black)
                                  : Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (slot.deliveryFee == 0 && slot.isAvailable)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'FREE',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        slot.timeRange,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: slot.isAvailable ? Colors.grey.shade600 : Colors.grey.shade400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        slot.description,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: slot.isAvailable ? Colors.grey.shade500 : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                if (slot.isAvailable)
                  Radio<String>(
                    value: slot.id,
                    groupValue: selectedTimeSlotId,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        selectedTimeSlotId = value;
                      });
                    },
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'UNAVAILABLE',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
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

  Widget _buildConfirmButton() {
    final selectedSlot = _timeSlots.firstWhere(
      (slot) => slot.id == selectedTimeSlotId,
      orElse: () => _timeSlots.first,
    );

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          if (selectedOption == DeliveryTimeSlot.scheduled) ...[
            Row(
              children: [
                Icon(Icons.schedule, color: Colors.blue, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Delivery: ${selectedSlot.timeRange}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),

              ],
            ),
            const SizedBox(height: 12),
          ],
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _confirmDelivery,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Confirm Delivery (${selectedOption == DeliveryTimeSlot.asSoonAsPossible ? '30-45 mins' : selectedSlot.timeRange})',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelivery() {
    if (selectedOption == DeliveryTimeSlot.scheduled && selectedTimeSlotId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a delivery time slot'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final selectedSlot = _timeSlots.firstWhere(
      (slot) => slot.id == (selectedTimeSlotId ?? _timeSlots.first.id),
    );

    Navigator.pop(context, {
      'option': selectedOption,
      'timeSlot': selectedSlot,
    });
  }
}