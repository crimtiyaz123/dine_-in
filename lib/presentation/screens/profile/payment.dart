// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String orderType;
  final String? restaurantName;
  final String? tableNumber;

  const PaymentPage({
    super.key,
    required this.orderType,
    this.restaurantName,
    this.tableNumber,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPayment = "UPI";
  
  // Mock payment data
  double totalAmount = 570.0;
  double tax = 28.5;

  double get finalAmount => totalAmount + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Payment"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top section content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Type Info
                  _buildOrderTypeInfo(),
                  const SizedBox(height: 20),
                  
                  // Order Summary
                  _buildOrderSummary(),
                  const SizedBox(height: 20),

                  const Text(
                    "Select Payment Method",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  _paymentOption("UPI (GooglePay / PhonePe)", "UPI", Icons.account_balance_wallet),
                  const SizedBox(height: 10),

                  _paymentOption("Credit / Debit Card", "CARD", Icons.credit_card),
                ],
              ),
            ),

            // Bottom section - Pay Now Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: _processPayment,
                child: Text(
                  "Pay ₹${finalAmount.toInt()}",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOrderTypeInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.orderType == "delivery" ? Colors.blue.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.orderType == "delivery" ? Colors.blue.shade200 : Colors.orange.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                widget.orderType == "delivery" ? Icons.delivery_dining : Icons.table_restaurant,
                color: widget.orderType == "delivery" ? Colors.blue : Colors.orange,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                widget.orderType == "delivery" ? "Delivery Order" : "Dine-In Order",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.orderType == "delivery" ? Colors.blue : Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (widget.orderType == "delivery") ...[
            Text(
              "Restaurant: ${widget.restaurantName ?? 'Restaurant'}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Text(
              "Estimated delivery time: 30-45 minutes",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ] else ...[
            Text(
              "Restaurant: ${widget.restaurantName ?? 'Restaurant'}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              "Table: ${widget.tableNumber ?? 'Not selected'}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Text(
              "Order will be served at your table",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Summary",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Items Total"),
              Text("₹${totalAmount.toInt()}"),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tax"),
              Text("₹${tax.toInt()}"),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "₹${finalAmount.toInt()}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _processPayment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Payment'),
        content: Text('Pay ₹${finalAmount.toInt()} using $selectedPayment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              String message = widget.orderType == "delivery" 
                  ? 'Payment successful! Your delivery order has been placed.'
                  : 'Payment successful! Your table order has been placed.';
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Pay Now', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // RADIO BUTTON STYLE PAYMENT OPTION
  Widget _paymentOption(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          Radio(
            value: value,
            // ignore: deprecated_member_use
            groupValue: selectedPayment,
            activeColor: Colors.green,
            onChanged: (val) {
              setState(() {
                selectedPayment = val.toString();
              });
            },
          )
        ],
      ),
    );
  }
}
