import 'package:flutter/material.dart';
import 'package:dine_in/core/services/widget_support.dart';
import 'package:dine_in/presentation/screens/profile/promotional_codes.dart';
import 'package:dine_in/presentation/screens/profile/delivery_schedule.dart';
import 'package:dine_in/presentation/screens/profile/payment.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class OrderPage extends StatefulWidget {
  final String orderType;
  final String? restaurantName;

  const OrderPage({
    super.key,
    required this.orderType,
    this.restaurantName,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Promo code related variables
  String? appliedPromoCode;
  double promoDiscount = 0.0;
  
  // Delivery scheduling variables
  Map<String, dynamic>? deliverySchedule;
  
  // Table selection for dine-in orders
  String? selectedTable;
  
  List<CartItem> cartItems = [
    CartItem(
      id: '1',
      name: 'Chicken Biryani',
      price: 250.0,
      image: 'images/biryani.png',
      quantity: 2,
    ),
    CartItem(
      id: '2',
      name: 'Raita',
      price: 35.0,
      image: 'images/desserts.png',
      quantity: 1,
    ),
    CartItem(
      id: '3',
      name: 'Papad',
      price: 15.0,
      image: 'images/chinese.png',
      quantity: 2,
    ),
  ];

  double get totalAmount {
    return cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  
  double scheduledDeliveryFee = 0.0;
  double tax = 0.0;

  @override
  Widget build(BuildContext context) {
    tax = (totalAmount - promoDiscount) * 0.05; // 5% tax on discounted amount
    double finalTotal = totalAmount + tax - promoDiscount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.orderType == "delivery" ? 'Your Cart' : 'Table Order'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: _clearCart,
            ),
        ],
      ),
      body: cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      bottomNavigationBar: cartItems.isEmpty ? null : _buildCheckoutSection(finalTotal),
    );
  }

  Widget _buildEmptyCart() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add some delicious food items!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return _buildCartItem(item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item.image,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 60,
                    width: 60,
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
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${item.price.toInt()}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _quantityButton(
                  icon: Icons.remove,
                  onPressed: () => _updateQuantity(item.id, -1),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _quantityButton(
                  icon: Icons.add,
                  onPressed: () => _updateQuantity(item.id, 1),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _removeItem(item.id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton({required IconData icon, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          size: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCheckoutSection(double finalTotal) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Delivery Schedule or Table Selection Section
            widget.orderType == "delivery" 
                ? _buildDeliveryScheduleSection()
                : _buildTableSelectionSection(),
            const SizedBox(height: 12),
            
            // Promo Code Section
            _buildPromoCodeSection(),
            const SizedBox(height: 12),
            
            // Price Breakdown
            _buildPriceRow('Subtotal', '₹${totalAmount.toInt()}'),
            if (promoDiscount > 0) ...[
              _buildPriceRow('Discount', '-₹${promoDiscount.toInt()}', isDiscount: true),
              _buildPriceRow('Discounted Subtotal', '₹${(totalAmount - promoDiscount).toInt()}'),
            ],

            _buildPriceRow('Tax', '₹${tax.toInt()}'),
            const Divider(),
            _buildPriceRow('Total', '₹${finalTotal.toInt()}', isTotal: true),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _proceedToCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  widget.orderType == "delivery" ? 'Proceed to Checkout' : 'Place Table Order',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryScheduleSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: Colors.blue, size: 20),
              const SizedBox(width: 8),
              Text(
                'Delivery Time',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              const Spacer(),
              if (deliverySchedule != null)
                GestureDetector(
                  onTap: _changeDeliverySchedule,
                  child: Text(
                    'Change',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (deliverySchedule == null)
            ElevatedButton.icon(
              onPressed: _changeDeliverySchedule,
              icon: const Icon(Icons.schedule, size: 16),
              label: const Text('Schedule Delivery'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.blue,
                side: BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(deliverySchedule!['option'] == DeliveryTimeSlot.asSoonAsPossible 
                      ? Icons.timer : Icons.schedule, color: Colors.blue, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    deliverySchedule!['option'] == DeliveryTimeSlot.asSoonAsPossible 
                        ? 'ASAP (30-45 mins)'
                        : deliverySchedule!['timeSlot'].timeRange,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTableSelectionSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.table_restaurant, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Text(
                'Select Table',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              const Spacer(),
              if (selectedTable != null)
                GestureDetector(
                  onTap: _changeTableSelection,
                  child: Text(
                    'Change',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (selectedTable == null)
            ElevatedButton.icon(
              onPressed: _changeTableSelection,
              icon: const Icon(Icons.table_restaurant, size: 16),
              label: const Text('Select Table'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.orange,
                side: BorderSide(color: Colors.orange),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.table_restaurant, color: Colors.orange, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Table $selectedTable',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_offer, color: Colors.green, size: 20),
              const SizedBox(width: 8),
              Text(
                'Promo Code',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              const Spacer(),
              if (appliedPromoCode != null)
                GestureDetector(
                  onTap: _removePromoCode,
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (appliedPromoCode == null)
            ElevatedButton.icon(
              onPressed: _applyPromoCode,
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Promo Code'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.green,
                side: BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    appliedPromoCode!,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : (isTotal ? Colors.black : Colors.grey.shade600),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : (isTotal ? Colors.black : Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }

  void _updateQuantity(String itemId, int change) {
    setState(() {
      final item = cartItems.firstWhere((item) => item.id == itemId);
      item.quantity += change;
      
      if (item.quantity <= 0) {
        cartItems.removeWhere((item) => item.id == itemId);
      }
    });
  }

  void _removeItem(String itemId) {
    setState(() {
      cartItems.removeWhere((item) => item.id == itemId);
    });
  }

  void _clearCart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to clear your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                cartItems.clear();
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _proceedToCheckout() {
    if (widget.orderType == "dine_in" && selectedTable == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a table for your order'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          orderType: widget.orderType,
          restaurantName: widget.restaurantName,
          tableNumber: selectedTable,
        ),
      ),
    );
  }

  void _applyPromoCode() async {
    final promoCode = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PromotionalCodesPage(),
      ),
    );

    if (promoCode != null) {
      setState(() {
        appliedPromoCode = promoCode.code;
        
        // Calculate discount based on promo code type
        if (promoCode.discountType == "percentage") {
          promoDiscount = (totalAmount * promoCode.discountValue) / 100;
        } else {
          promoDiscount = promoCode.discountValue;
        }
        
        // Ensure discount doesn't exceed subtotal
        if (promoDiscount > totalAmount) {
          promoDiscount = totalAmount;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Promo code "${promoCode.code}" applied!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _removePromoCode() {
    setState(() {
      appliedPromoCode = null;
      promoDiscount = 0.0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Promo code removed'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _changeDeliverySchedule() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliverySchedulePage(orderAmount: totalAmount - promoDiscount),
      ),
    );

    if (result != null) {
      setState(() {
        deliverySchedule = result;
      });
    }
  }

  void _changeTableSelection() async {
    final tableNumber = await showDialog<String>(
      context: context,
      builder: (context) => TableSelectionDialog(
        currentTable: selectedTable,
        restaurantName: widget.restaurantName ?? "Restaurant",
      ),
    );

    if (tableNumber != null) {
      setState(() {
        selectedTable = tableNumber;
      });
    }
  }
}

class TableSelectionDialog extends StatefulWidget {
  final String? currentTable;
  final String restaurantName;

  const TableSelectionDialog({
    super.key,
    this.currentTable,
    required this.restaurantName,
  });

  @override
  State<TableSelectionDialog> createState() => _TableSelectionDialogState();
}

class _TableSelectionDialogState extends State<TableSelectionDialog> {
  String? selectedTable;

  @override
  void initState() {
    super.initState();
    selectedTable = widget.currentTable;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Table - ${widget.restaurantName}'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose your preferred table:'),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 20, // 20 tables
                itemBuilder: (context, index) {
                  final tableNumber = (index + 1).toString();
                  final isSelected = selectedTable == tableNumber;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTable = tableNumber;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange : Colors.grey.shade200,
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.grey.shade400,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          tableNumber,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedTable != null) {
              Navigator.pop(context, selectedTable);
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text('Select Table', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}