import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PromotionalCodesPage extends StatefulWidget {
  const PromotionalCodesPage({super.key});

  @override
  State<PromotionalCodesPage> createState() => _PromotionalCodesPageState();
}

class PromoCode {
  final String id;
  final String code;
  final String title;
  final String description;
  final String discountType; // 'percentage' or 'fixed'
  final double discountValue;
  final String minOrderAmount;
  final String expiryDate;
  final String validOn; // 'all', 'restaurants', 'categories'
  final List<String> applicableCategories;
  final bool isActive;
  final int usageLimit;
  final int usedCount;

  PromoCode({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.minOrderAmount,
    required this.expiryDate,
    required this.validOn,
    required this.applicableCategories,
    this.isActive = true,
    this.usageLimit = 100,
    this.usedCount = 0,
  });
}

class _PromotionalCodesPageState extends State<PromotionalCodesPage> {
  final TextEditingController _codeController = TextEditingController();
  String _selectedFilter = "Available";
  
  final List<PromoCode> _promoCodes = [
    PromoCode(
      id: "1",
      code: "FIRST50",
      title: "First Order Discount",
      description: "Get 50% off on your first order",
      discountType: "percentage",
      discountValue: 50.0,
      minOrderAmount: "200",
      expiryDate: "2025-12-31",
      validOn: "all",
      applicableCategories: [],
    ),
    
    PromoCode(
      id: "3",
      code: "BIRYANI20",
      title: "Biryani Special",
      description: "20% off on all biryani items",
      discountType: "percentage",
      discountValue: 20.0,
      minOrderAmount: "150",
      expiryDate: "2025-12-15",
      validOn: "categories",
      applicableCategories: ["Biryani"],
    ),
    PromoCode(
      id: "4",
      code: "PIZZA30",
      title: "Pizza Feast",
      description: "₹30 off on pizza orders",
      discountType: "fixed",
      discountValue: 30.0,
      minOrderAmount: "250",
      expiryDate: "2025-11-25",
      validOn: "categories",
      applicableCategories: ["Pizza"],
    ),
    PromoCode(
      id: "5",
      code: "WELCOME100",
      title: "Welcome Bonus",
      description: "₹100 off on orders above ₹500",
      discountType: "fixed",
      discountValue: 100.0,
      minOrderAmount: "500",
      expiryDate: "2025-12-31",
      validOn: "all",
      applicableCategories: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Promo Codes',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black),
            onPressed: () => _showPromoInfo(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCodeEntrySection(),
          _buildFilterTabs(),
          Expanded(
            child: _buildPromoCodesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeEntrySection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Have a promo code?',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    hintText: 'Enter promo code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  textCapitalization: TextCapitalization.characters,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _applyPromoCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  'Apply',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: _buildFilterTab("Available", Colors.green),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: _buildFilterTab("Used", Colors.grey),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: _buildFilterTab("Expired", Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String filter, Color color) {
    final isSelected = _selectedFilter == filter;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filter;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade100,
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          filter,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? color : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Widget _buildPromoCodesList() {
    List<PromoCode> filteredCodes = _getFilteredPromoCodes();
    
    if (filteredCodes.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredCodes.length,
      itemBuilder: (context, index) {
        final promo = filteredCodes[index];
        return _buildPromoCodeCard(promo);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_offer_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No ${_selectedFilter.toLowerCase()} codes',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedFilter == "Available" 
                ? 'Check back later for new offers'
                : _selectedFilter == "Used"
                    ? 'Codes you\'ve used will appear here'
                    : 'Expired codes will appear here',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCodeCard(PromoCode promo) {
    final bool isExpired = DateTime.parse(promo.expiryDate).isBefore(DateTime.now());
    final bool isMaxUsed = promo.usedCount >= promo.usageLimit;
    final bool isAvailable = _selectedFilter == "Available";
    
    Color cardColor;
    Color borderColor;
    
    if (isExpired) {
      cardColor = Colors.red.shade50;
      borderColor = Colors.red.shade200;
    } else if (isMaxUsed) {
      cardColor = Colors.orange.shade50;
      borderColor = Colors.orange.shade200;
    } else if (isAvailable) {
      cardColor = Colors.green.shade50;
      borderColor = Colors.green.shade200;
    } else {
      cardColor = Colors.grey.shade50;
      borderColor = Colors.grey.shade200;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      promo.code,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (isExpired)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'EXPIRED',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    )
                  else if (isMaxUsed)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'MAX USED',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    )
                  else if (isAvailable)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'AVAILABLE',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                promo.title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                promo.description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discount: ${_formatDiscount(promo)}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'Min order: ₹${promo.minOrderAmount}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          'Valid till: ${_formatDate(promo.expiryDate)}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isAvailable && !isExpired && !isMaxUsed)
                    ElevatedButton(
                      onPressed: () => _copyPromoCode(promo.code),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        'Copy Code',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDiscount(PromoCode promo) {
    if (promo.discountType == "percentage") {
      return "${promo.discountValue.toInt()}% off";
    } else {
      return "₹${promo.discountValue.toInt()} off";
    }
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return "${date.day}/${date.month}/${date.year}";
  }

  List<PromoCode> _getFilteredPromoCodes() {
    switch (_selectedFilter) {
      case "Available":
        return _promoCodes.where((promo) {
          final isExpired = DateTime.parse(promo.expiryDate).isBefore(DateTime.now());
          final isMaxUsed = promo.usedCount >= promo.usageLimit;
          return promo.isActive && !isExpired && !isMaxUsed;
        }).toList();
      case "Used":
        return _promoCodes.where((promo) => promo.usedCount > 0).toList();
      case "Expired":
        return _promoCodes.where((promo) {
          return DateTime.parse(promo.expiryDate).isBefore(DateTime.now());
        }).toList();
      default:
        return _promoCodes;
    }
  }

  void _applyPromoCode() {
    final enteredCode = _codeController.text.toUpperCase().trim();
    
    if (enteredCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a promo code'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final promo = _promoCodes.firstWhere(
      (p) => p.code == enteredCode,
      orElse: () => throw Exception('Code not found'),
    );

    if (DateTime.parse(promo.expiryDate).isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This promo code has expired'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (promo.usedCount >= promo.usageLimit) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This promo code has reached its usage limit'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    Navigator.pop(context, promo);
  }

  void _copyPromoCode(String code) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Code "$code" copied to clipboard'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'Use Now',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showPromoInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How Promo Codes Work'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Promo codes can only be applied once per order'),
            SizedBox(height: 8),
            Text('• Minimum order amount must be met to use a code'),
            SizedBox(height: 8),
            Text('• Some codes may be valid only for specific restaurants or categories'),
            SizedBox(height: 8),
            Text('• Promo codes cannot be combined with other offers'),
            SizedBox(height: 8),
            Text('• Usage is limited per user unless specified otherwise'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}