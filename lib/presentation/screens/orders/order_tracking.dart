import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderTrackingPage extends StatefulWidget {
  final String orderId;
  final String restaurantName;
  final String estimatedTime;

  const OrderTrackingPage({
    super.key,
    required this.orderId,
    required this.restaurantName,
    required this.estimatedTime,
  });

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  int _currentStep = 0;
  Timer? _trackingTimer;

  final List<OrderStep> _orderSteps = [
    OrderStep(
      title: "Order Placed",
      subtitle: "Your order has been confirmed",
      icon: Icons.shopping_cart,
      color: Colors.green,
    ),
    OrderStep(
      title: "Restaurant Confirmed",
      subtitle: "Restaurant is preparing your order",
      icon: Icons.restaurant,
      color: Colors.blue,
    ),
    OrderStep(
      title: "Preparing Food",
      subtitle: "Your delicious food is being cooked",
      icon: Icons.local_fire_department,
      color: Colors.orange,
    ),
   
    OrderStep(
      title: "Delivered",
      subtitle: "Order delivered successfully",
      icon: Icons.check_circle,
      color: Colors.green,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Simulate real-time order updates
    _startOrderTracking();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _trackingTimer?.cancel();
    super.dispose();
  }

  void _startOrderTracking() {
    // Start with step 0
    setState(() {
      _currentStep = 0;
    });
    _animationController.forward();

    // Simulate real-time updates every 3-4 seconds
    _trackingTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (_currentStep < _orderSteps.length - 1) {
          _currentStep++;
          
          // Trigger animations for new step
          _animationController.reset();
          _animationController.forward();
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: _buildOrderInfo(),
          ),
          SliverToBoxAdapter(
            child: _buildDeliveryPersonInfo(),
          ),
          SliverToBoxAdapter(
            child: _buildOrderTrackingSteps(),
          ),
          SliverToBoxAdapter(
            child: _buildOrderDetails(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Track Order',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.green.shade600,
                Colors.green.shade400,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.delivery_dining,
                  size: 60,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Text(
                  'Order #${widget.orderId}',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.phone, color: Colors.white),
          onPressed: () => _callDeliveryPerson(),
        ),
        IconButton(
          icon: const Icon(Icons.message, color: Colors.white),
          onPressed: () => _messageDeliveryPerson(),
        ),
      ],
    );
  }

  Widget _buildOrderInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.restaurant,
                  color: Colors.green.shade600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurantName,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Estimated delivery: ${widget.estimatedTime}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: _progressAnimation.value,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Text(
            _orderSteps[_currentStep].subtitle,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryPersonInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.shade100,
            child: const Icon(Icons.person, size: 30, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rajesh Kumar',
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
                      '4.8',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '2.5 km away',
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
          Column(
            children: [
              _buildActionButton(
                icon: Icons.phone,
                color: Colors.green,
                onTap: _callDeliveryPerson,
              ),
              const SizedBox(height: 8),
              _buildActionButton(
                icon: Icons.message,
                color: Colors.blue,
                onTap: _messageDeliveryPerson,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  Widget _buildOrderTrackingSteps() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Status',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(_orderSteps.length, (index) {
            return _buildStep(
              _orderSteps[index],
              index,
              index <= _currentStep,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStep(OrderStep step, int index, bool isCompleted) {
    final isActive = index == _currentStep;
    final isLast = index == _orderSteps.length - 1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isCompleted ? step.color.withOpacity(0.1) : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                step.icon,
                color: isCompleted ? step.color : Colors.grey.shade500,
                size: 20,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: isCompleted ? step.color : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isCompleted ? Colors.black : Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                step.subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isCompleted ? Colors.grey.shade600 : Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        if (isActive)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: step.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'IN PROGRESS',
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: step.color,
              ),
            ),
          ),
        if (isCompleted && !isActive)
          Icon(
            Icons.check_circle,
            color: step.color,
            size: 20,
          ),
      ],
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Items',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...[
            {'name': 'Chicken Biryani', 'quantity': 2, 'price': '₹500'},
            {'name': 'Raita', 'quantity': 1, 'price': '₹35'},
            {'name': 'Papad', 'quantity': 2, 'price': '₹30'},
          ].map((item) => _buildOrderItem(item)).toList(),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₹565',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['name'],
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Qty: ${item['quantity']}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Text(
            item['price'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
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
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order help feature coming soon!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Need Help',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Track More Orders',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _callDeliveryPerson() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Calling delivery partner...')),
    );
  }

  void _messageDeliveryPerson() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening chat with delivery partner...')),
    );
  }
}

class OrderStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  OrderStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}