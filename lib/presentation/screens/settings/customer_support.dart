import 'package:flutter/material.dart';

class CustomerSupportPage extends StatefulWidget {
  const CustomerSupportPage({super.key});

  @override
  State<CustomerSupportPage> createState() => _CustomerSupportPageState();
}

class _CustomerSupportPageState extends State<CustomerSupportPage> 
    with TickerProviderStateMixin {
  
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _ticketController = TextEditingController();
  
  String _searchQuery = '';
  bool _isTyping = false;
  
  // Sample FAQ data
  final List<Map<String, dynamic>> _faqData = [
    {
      'question': 'How do I track my order?',
      'answer': 'You can track your order in the Orders section. We provide real-time updates on your food preparation and delivery.',
      'category': 'Orders',
      'popular': true,
    },
    {
      'question': 'What are your delivery hours?',
      'answer': 'We deliver from 9:00 AM to 11:00 PM daily. Some restaurants may have different hours.',
      'category': 'Delivery',
      'popular': true,
    },
    {
      'question': 'How do I apply a promo code?',
      'answer': 'Go to your cart, enter the promo code in the designated field, and the discount will be applied automatically.',
      'category': 'Payment',
      'popular': false,
    },
    {
      'question': 'Can I modify my order after placing it?',
      'answer': 'You can modify your order within 5 minutes of placing it. Contact support immediately for changes.',
      'category': 'Orders',
      'popular': false,
    },
    {
      'question': 'What payment methods do you accept?',
      'answer': 'We accept credit/debit cards, digital wallets, net banking, and cash on delivery.',
      'category': 'Payment',
      'popular': true,
    },
    {
      'question': 'How do I cancel my order?',
      'answer': 'You can cancel your order from the Orders section before the restaurant starts preparing your food.',
      'category': 'Orders',
      'popular': false,
    },
    {
      'question': 'Is there a minimum order value?',
      'answer': 'Yes, most restaurants have a minimum order value of ₹100. This varies by restaurant.',
      'category': 'Orders',
      'popular': false,
    },
    {
      'question': 'Do you offer refunds?',
      'answer': 'We provide refunds for order cancellations and food quality issues. Contact support for refund requests.',
      'category': 'Payment',
      'popular': false,
    },
  ];
  
  // Chat messages (simulated)
  final List<Map<String, dynamic>> _chatMessages = [
    {
      'message': 'Hello! How can I help you today?',
      'isBot': true,
      'timestamp': '10:30 AM',
    },
    {
      'message': 'Hi, I want to know about my order status',
      'isBot': false,
      'timestamp': '10:31 AM',
    },
    {
      'message': 'I can help you with that! Could you please provide your order number?',
      'isBot': true,
      'timestamp': '10:31 AM',
    },
  ];

  // Ticket history
  final List<Map<String, dynamic>> _ticketHistory = [
    {
      'id': 'TKT-001',
      'subject': 'Order delivery issue',
      'status': 'Resolved',
      'priority': 'High',
      'date': '2025-11-25',
    },
    {
      'id': 'TKT-002',
      'subject': 'Payment refund request',
      'status': 'In Progress',
      'priority': 'Medium',
      'date': '2025-11-24',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _messageController.dispose();
    _ticketController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Customer Support"),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.help), text: "FAQ"),
            Tab(icon: Icon(Icons.chat), text: "Live Chat"),
            Tab(icon: Icon(Icons.confirmation_number), text: "Tickets"),
            Tab(icon: Icon(Icons.contact_phone), text: "Contact"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFAQTab(),
          _buildLiveChatTab(),
          _buildTicketsTab(),
          _buildContactTab(),
        ],
      ),
    );
  }

  Widget _buildFAQTab() {
    final filteredFAQ = _searchQuery.isEmpty
        ? _faqData
        : _faqData.where((faq) =>
            faq['question'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
            faq['answer'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
            faq['category'].toString().toLowerCase().contains(_searchQuery.toLowerCase())
        ).toList();

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search FAQ...',
              prefixIcon: const Icon(Icons.search, color: Colors.green),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.green, width: 2),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),

        // Popular questions
        if (_searchQuery.isEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Popular Questions',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildPopularQuestions(),
          const SizedBox(height: 16),
        ],

        // FAQ list
        Expanded(
          child: filteredFAQ.isEmpty
              ? const Center(
                  child: Text('No FAQ found matching your search'),
                )
              : ListView.builder(
                  itemCount: filteredFAQ.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final faq = filteredFAQ[index];
                    return _buildFAQItem(faq);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildPopularQuestions() {
    final popularFAQ = _faqData.where((faq) => faq['popular'] == true).toList();
    
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: popularFAQ.length,
        itemBuilder: (context, index) {
          final faq = popularFAQ[index];
          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: 12),
            child: Card(
              color: Colors.green.shade50,
              child: InkWell(
                onTap: () => _showFAQDetail(faq),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.star, color: Colors.orange.shade600, size: 16),
                      const SizedBox(height: 8),
                      Text(
                        faq['question'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          faq['category'],
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          faq['question'],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(faq['category']),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(faq['answer']),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveChatTab() {
    return Column(
      children: [
        // Chat messages
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _chatMessages.length,
            itemBuilder: (context, index) {
              final message = _chatMessages[index];
              return _buildChatMessage(message);
            },
          ),
        ),
        
        // Typing indicator
        if (_isTyping)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.support_agent, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Agent is typing...'),
                ),
              ],
            ),
          ),

        // Message input
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(25),
          ),
          margin: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type your message...',
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                ),
              ),
              IconButton(
                onPressed: () => _sendMessage(),
                icon: const Icon(Icons.send, color: Colors.green),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChatMessage(Map<String, dynamic> message) {
    final isBot = message['isBot'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isBot) ...[
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.support_agent, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isBot ? Colors.green.shade50 : Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isBot ? Radius.zero : const Radius.circular(20),
                  bottomRight: isBot ? const Radius.circular(20) : Radius.zero,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['message'],
                    style: TextStyle(
                      color: isBot ? Colors.black87 : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message['timestamp'],
                    style: TextStyle(
                      fontSize: 12,
                      color: isBot ? Colors.grey.shade600 : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isBot) const SizedBox(width: 8),
          if (!isBot)
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.person, color: Colors.grey.shade600, size: 20),
            ),
        ],
      ),
    );
  }

  Widget _buildTicketsTab() {
    return Column(
      children: [
        // Create new ticket button
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () => _showCreateTicketDialog(),
              icon: const Icon(Icons.add),
              label: const Text('Create New Ticket'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ),

        // Tickets list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _ticketHistory.length,
            itemBuilder: (context, index) {
              final ticket = _ticketHistory[index];
              return _buildTicketItem(ticket);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTicketItem(Map<String, dynamic> ticket) {
    Color statusColor;
    switch (ticket['status']) {
      case 'Resolved':
        statusColor = Colors.green;
        break;
      case 'In Progress':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withValues(alpha: 0.1),
          child: Icon(Icons.confirmation_number, color: statusColor),
        ),
        title: Text(
          ticket['subject'],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${ticket['id']}'),
            Text('Date: ${ticket['date']}'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                ticket['status'],
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              ticket['priority'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        onTap: () => _showTicketDetail(ticket),
      ),
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact methods
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get in Touch',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildContactItem(
                    Icons.phone,
                    'Phone',
                    '+91 98765 43210',
                    'Mon-Sun: 9:00 AM - 11:00 PM',
                    () => _makePhoneCall(),
                  ),
                  _buildContactItem(
                    Icons.email,
                    'Email',
                    'support@dinein.com',
                    'We respond within 2 hours',
                    () => _sendEmail(),
                  ),
                  _buildContactItem(
                    Icons.chat_bubble,
                    'Live Chat',
                    'Instant support',
                    'Available 24/7',
                    () => _tabController.animateTo(1),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // FAQ categories
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Help',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2,
                    children: [
                      _buildCategoryCard('Orders', Icons.shopping_bag, () {
                        _filterFAQ('Orders');
                      }),
                      _buildCategoryCard('Payment', Icons.payment, () {
                        _filterFAQ('Payment');
                      }),
                      _buildCategoryCard('Delivery', Icons.local_shipping, () {
                        _filterFAQ('Delivery');
                      }),
                      _buildCategoryCard('Account', Icons.person, () {
                        _filterFAQ('Account');
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Operating hours
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Operating Hours',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildHoursRow('Customer Support', 'Mon - Sun', '9:00 AM - 11:00 PM'),
                  _buildHoursRow('Live Chat', 'Mon - Sun', '24/7'),
                  _buildHoursRow('Phone Support', 'Mon - Sun', '9:00 AM - 11:00 PM'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String subtitle, String description, VoidCallback onTap) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green.shade50,
        child: Icon(icon, color: Colors.green),
      ),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(description),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.green, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoursRow(String service, String days, String hours) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(service, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(days, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
          ),
          Text(hours, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // Action methods
  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _chatMessages.add({
          'message': _messageController.text.trim(),
          'isBot': false,
          'timestamp': _getCurrentTime(),
        });
      });
      
      _messageController.clear();
      
      // Simulate bot response
      _simulateBotResponse();
    }
  }

  void _simulateBotResponse() {
    setState(() {
      _isTyping = true;
    });
    
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTyping = false;
        _chatMessages.add({
          'message': 'Thank you for your message. Our support team will get back to you shortly.',
          'isBot': true,
          'timestamp': _getCurrentTime(),
        });
      });
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}';
  }

  void _showFAQDetail(Map<String, dynamic> faq) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(faq['question']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(faq['answer']),
            const SizedBox(height: 16),
            Text('Category: ${faq['category']}', 
                 style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _tabController.animateTo(1);
            },
            child: const Text('Still Need Help?', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  void _showCreateTicketDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Support Ticket'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _ticketController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ticket created successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showTicketDetail(Map<String, dynamic> ticket) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ticket['id']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Subject: ${ticket['subject']}'),
            Text('Status: ${ticket['status']}'),
            Text('Priority: ${ticket['priority']}'),
            Text('Date: ${ticket['date']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _filterFAQ(String category) {
    _tabController.animateTo(0);
    _searchController.text = category;
    setState(() {
      _searchQuery = category;
    });
  }

  void _makePhoneCall() {
    // In a real app, you would use the url_launcher package
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Phone call feature would open dialer')),
    );
  }

  void _sendEmail() {
    // In a real app, you would use the url_launcher package
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email app would open')),
    );
  }
}