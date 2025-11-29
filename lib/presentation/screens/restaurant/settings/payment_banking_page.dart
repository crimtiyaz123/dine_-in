import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';

class PaymentBankingPage extends StatefulWidget {
  const PaymentBankingPage({super.key});

  @override
  State<PaymentBankingPage> createState() => _PaymentBankingPageState();
}

class _PaymentBankingPageState extends State<PaymentBankingPage> {
  final TextEditingController _accountHolderController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();

  String _selectedPaymentMethod = 'Bank Transfer';

  @override
  void initState() {
    super.initState();
    // Load existing payment details
    _loadPaymentDetails();
  }

  @override
  void dispose() {
    _accountHolderController.dispose();
    _accountNumberController.dispose();
    _ifscController.dispose();
    _bankNameController.dispose();
    _upiIdController.dispose();
    super.dispose();
  }

  void _loadPaymentDetails() {
    // Mock data - in real app, this would come from API
    _accountHolderController.text = 'John Doe';
    _accountNumberController.text = '123456789012';
    _ifscController.text = 'SBIN0001234';
    _bankNameController.text = 'State Bank of India';
    _upiIdController.text = 'john.doe@upi';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Payment & Banking',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
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
                  Text(
                    'Payment Information',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Set up your payment methods to receive earnings from orders',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Payment Method Selection
            Text(
              'Preferred Payment Method',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            Container(
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
                children: [
                  _buildPaymentMethodOption('Bank Transfer'),
                  const Divider(),
                  _buildPaymentMethodOption('UPI'),
                  const Divider(),
                  _buildPaymentMethodOption('PayPal'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Bank Details Section
            if (_selectedPaymentMethod == 'Bank Transfer') ...[
              Text(
                'Bank Account Details',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 12),

              Container(
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
                  children: [
                    CustomTextField(
                      _accountHolderController,
                      hintText: 'Account Holder Name',
                      prefixIcon: Icons.person,
                    ),

                    const SizedBox(height: 16),

                    CustomTextField(
                      _accountNumberController,
                      hintText: 'Account Number',
                      prefixIcon: Icons.account_balance,
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 16),

                    CustomTextField(
                      _ifscController,
                      hintText: 'IFSC Code',
                      prefixIcon: Icons.code,
                    ),

                    const SizedBox(height: 16),

                    CustomTextField(
                      _bankNameController,
                      hintText: 'Bank Name',
                      prefixIcon: Icons.account_balance_wallet,
                    ),
                  ],
                ),
              ),
            ],

            // UPI Details Section
            if (_selectedPaymentMethod == 'UPI') ...[
              Text(
                'UPI Details',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 12),

              Container(
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
                child: CustomTextField(
                  _upiIdController,
                  hintText: 'UPI ID (e.g., yourname@upi)',
                  prefixIcon: Icons.payment,
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Save button
            CustomButton(
              text: 'Save Payment Details',
              onPressed: _savePaymentDetails,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            ),

            const SizedBox(height: 16),

            // Security note
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.security, color: Colors.blue.shade600, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your payment information is encrypted and secure. We never store your banking details on our servers.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodOption(String method) {
    final isSelected = _selectedPaymentMethod == method;

    return InkWell(
      onTap: () => setState(() => _selectedPaymentMethod = method),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              _getPaymentMethodIcon(method),
              color: isSelected ? Colors.green : Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                method,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isSelected ? Colors.green : Colors.black,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.green, size: 20),
          ],
        ),
      ),
    );
  }

  IconData _getPaymentMethodIcon(String method) {
    switch (method) {
      case 'Bank Transfer':
        return Icons.account_balance;
      case 'UPI':
        return Icons.payment;
      case 'PayPal':
        return Icons.paypal;
      default:
        return Icons.payment;
    }
  }

  void _savePaymentDetails() {
    // Validate inputs
    if (_selectedPaymentMethod == 'Bank Transfer') {
      if (_accountHolderController.text.isEmpty ||
          _accountNumberController.text.isEmpty ||
          _ifscController.text.isEmpty ||
          _bankNameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please fill all bank details',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    } else if (_selectedPaymentMethod == 'UPI') {
      if (_upiIdController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please enter UPI ID',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    // Save payment details logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Payment details saved successfully!',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate back after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
