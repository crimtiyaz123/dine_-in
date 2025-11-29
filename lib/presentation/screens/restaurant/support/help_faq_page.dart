import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpFaqPage extends StatefulWidget {
  const HelpFaqPage({super.key});

  @override
  State<HelpFaqPage> createState() => _HelpFaqPageState();
}

class _HelpFaqPageState extends State<HelpFaqPage> {
  final List<Map<String, dynamic>> _faqCategories = [
    {
      'title': 'Getting Started',
      'icon': Icons.rocket_launch,
      'faqs': [
        {
          'question': 'How do I set up my restaurant profile?',
          'answer': 'Go to Settings > Restaurant Profile and fill in your restaurant details including name, description, address, and contact information.',
        },
        {
          'question': 'How do I add menu items?',
          'answer': 'Navigate to Menu > Add Category, then add food items to each category with prices, descriptions, and images.',
        },
      ],
    },
    {
      'title': 'Orders & Payments',
      'icon': Icons.shopping_cart,
      'faqs': [
        {
          'question': 'How do I receive order notifications?',
          'answer': 'Order notifications are sent automatically. You can also check the Orders section for new orders.',
        },
        {
          'question': 'When do I get paid for orders?',
          'answer': 'Payments are processed within 24-48 hours after order completion. Check your Payment & Banking settings.',
        },
      ],
    },
    {
      'title': 'Menu Management',
      'icon': Icons.restaurant_menu,
      'faqs': [
        {
          'question': 'How do I update item availability?',
          'answer': 'In the Menu section, tap on any food item and use the availability toggle to show/hide items.',
        },
        {
          'question': 'Can I change prices?',
          'answer': 'Yes, edit any food item to update prices. Changes are reflected immediately for customers.',
        },
      ],
    },
    {
      'title': 'Account & Settings',
      'icon': Icons.settings,
      'faqs': [
        {
          'question': 'How do I update business hours?',
          'answer': 'Go to Settings > Business Hours and set your operating hours for each day of the week.',
        },
        {
          'question': 'How do I change my password?',
          'answer': 'Visit Settings > Account Security to update your password and security settings.',
        },
      ],
    },
  ];

  final Set<int> _expandedItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Help & FAQ',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Open search
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search FAQs...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey.shade400),
                ),
                style: GoogleFonts.poppins(),
              ),
            ),

            const SizedBox(height: 24),

            // Popular topics
            Text(
              'Popular Topics',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildPopularTopic(
                    'Order Issues',
                    Icons.error_outline,
                    Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPopularTopic(
                    'Payment Help',
                    Icons.payment,
                    Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildPopularTopic(
                    'Menu Setup',
                    Icons.restaurant_menu,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPopularTopic(
                    'Account Help',
                    Icons.account_circle,
                    Colors.blue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // FAQ Categories
            Text(
              'Frequently Asked Questions',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            ..._faqCategories.asMap().entries.map((entry) {
              final index = entry.key;
              final category = entry.value;
              final isExpanded = _expandedItems.contains(index);

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
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
                    // Category header
                    InkWell(
                      onTap: () => _toggleCategory(index),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                category['icon'],
                                color: Colors.green,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                category['title'],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Icon(
                              isExpanded ? Icons.expand_less : Icons.expand_more,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // FAQ items
                    if (isExpanded) ...[
                      const Divider(height: 1),
                      ...category['faqs'].asMap().entries.map((faqEntry) {
                        final faqIndex = faqEntry.key;
                        final faq = faqEntry.value;
                        final isFaqExpanded = _expandedItems.contains(index * 100 + faqIndex);

                        return Column(
                          children: [
                            InkWell(
                              onTap: () => _toggleFaq(index, faqIndex),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        faq['question'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      isFaqExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                      color: Colors.grey.shade600,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isFaqExpanded) ...[
                              Container(
                                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: Text(
                                  faq['answer'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      }),
                    ],
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),

            // Contact support
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.contact_support,
                    color: Colors.blue.shade600,
                    size: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Still need help?',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Contact our support team for personalized assistance',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.blue.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/restaurant/customer-support'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Contact Support',
                      style: GoogleFonts.poppins(),
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

  Widget _buildPopularTopic(String title, IconData icon, Color color) {
    return InkWell(
      onTap: () => _openTopic(title),
      child: Container(
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
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _toggleCategory(int index) {
    setState(() {
      if (_expandedItems.contains(index)) {
        // Remove all FAQs in this category
        _expandedItems.removeWhere((item) => item >= index * 100 && item < (index + 1) * 100);
        _expandedItems.remove(index);
      } else {
        _expandedItems.add(index);
      }
    });
  }

  void _toggleFaq(int categoryIndex, int faqIndex) {
    setState(() {
      final faqKey = categoryIndex * 100 + faqIndex;
      if (_expandedItems.contains(faqKey)) {
        _expandedItems.remove(faqKey);
      } else {
        _expandedItems.add(faqKey);
      }
    });
  }

  void _openTopic(String topic) {
    // Navigate to specific help topic
    Navigator.pushNamed(context, '/restaurant/help-topic', arguments: topic);
  }
}
