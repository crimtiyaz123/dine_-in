import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressManagementPage extends StatefulWidget {
  const AddressManagementPage({super.key});

  @override
  State<AddressManagementPage> createState() => _AddressManagementPageState();
}

class Address {
  String id;
  String title;
  String address;
  String landmark;
  String area;
  String city;
  String state;
  String pincode;
  String phone;
  AddressType type;
  bool isDefault;

  Address({
    required this.id,
    required this.title,
    required this.address,
    required this.landmark,
    required this.area,
    required this.city,
    required this.state,
    required this.pincode,
    required this.phone,
    required this.type,
    this.isDefault = false,
  });
}

enum AddressType { home, office, other }

class _AddressManagementPageState extends State<AddressManagementPage> {
  List<Address> addresses = [
    Address(
      id: "1",
      title: "Home",
      address: "123, Green Valley Apartments, Tower A",
      landmark: "Near Metro Station",
      area: "Sector 15",
      city: "Anantnag",
      state: "Kashmir",
      pincode: "122001",
      phone: "+91 9876543210",
      type: AddressType.home,
      isDefault: true,
    ),
    Address(
      id: "2", 
      title: "Office",
      address: "456, Tech Park, Building 2",
      landmark: "Cyber City",
      area: "DLF Phase 3",
      city: "Anantnag",
      state: "Kashmir",
      pincode: "122002",
      phone: "+91 9876543210",
      type: AddressType.office,
      isDefault: false,
    ),
    Address(
      id: "3",
      title: "Friend's Place",
      address: "789, Residential Colony",
      landmark: "Central Market",
      area: "Sushant Lok",
      city: "Anantnag",
      state: "Kashmir",
      pincode: "122003",
      phone: "+91 9876543210",
      type: AddressType.other,
      isDefault: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Manage Addresses',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddAddressDialog(),
          ),
        ],
      ),
      body: addresses.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return _buildAddressCard(address);
              },
            ),
      floatingActionButton: addresses.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => _showAddAddressDialog(),
              backgroundColor: Colors.green,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No addresses saved',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add delivery addresses for faster checkout',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _showAddAddressDialog(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'Add Address',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Address address) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildAddressTypeIcon(address.type),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    address.title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (address.isDefault)
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
                      'DEFAULT',
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
              '${address.address}, ${address.landmark}',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              '${address.area}, ${address.city}, ${address.state} - ${address.pincode}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Phone: ${address.phone}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _editAddress(address),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Edit',
                      style: GoogleFonts.poppins(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _deleteAddress(address),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (!address.isDefault)
                  ElevatedButton(
                    onPressed: () => _setAsDefault(address),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Set Default',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressTypeIcon(AddressType type) {
    IconData icon;
    Color color;
    
    switch (type) {
      case AddressType.home:
        icon = Icons.home;
        color = Colors.blue;
        break;
      case AddressType.office:
        icon = Icons.work;
        color = Colors.orange;
        break;
      case AddressType.other:
        icon = Icons.location_on;
        color = Colors.purple;
        break;
    }
    
    return Container(
      padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  void _showAddAddressDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddressFormSheet(
        onSave: (addressData) {
          setState(() {
            final newAddress = Address(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: addressData['title'] ?? '',
              address: addressData['address'] ?? '',
              landmark: addressData['landmark'] ?? '',
              area: addressData['area'] ?? '',
              city: addressData['city'] ?? '',
              state: addressData['state'] ?? '',
              pincode: addressData['pincode'] ?? '',
              phone: addressData['phone'] ?? '',
              type: addressData['type'] ?? AddressType.other,
            );
            addresses.add(newAddress);
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Address added successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    );
  }

  void _editAddress(Address address) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddressFormSheet(
        address: address,
        onSave: (addressData) {
          setState(() {
            address.title = addressData['title'] ?? '';
            address.address = addressData['address'] ?? '';
            address.landmark = addressData['landmark'] ?? '';
            address.area = addressData['area'] ?? '';
            address.city = addressData['city'] ?? '';
            address.state = addressData['state'] ?? '';
            address.pincode = addressData['pincode'] ?? '';
            address.phone = addressData['phone'] ?? '';
            address.type = addressData['type'] ?? AddressType.other;
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Address updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    );
  }

  void _deleteAddress(Address address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Address'),
        content: const Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                addresses.removeWhere((a) => a.id == address.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Address deleted successfully!'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _setAsDefault(Address address) {
    setState(() {
      // Remove default from all addresses
      for (var addr in addresses) {
        addr.isDefault = false;
      }
      // Set the selected address as default
      address.isDefault = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Default address updated!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class AddressFormSheet extends StatefulWidget {
  final Address? address;
  final Function(Map<String, dynamic>) onSave;

  const AddressFormSheet({
    super.key,
    this.address,
    required this.onSave,
  });

  @override
  State<AddressFormSheet> createState() => _AddressFormSheetState();
}

class _AddressFormSheetState extends State<AddressFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController addressController;
  late TextEditingController landmarkController;
  late TextEditingController areaController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController pincodeController;
  late TextEditingController phoneController;
  
  AddressType selectedType = AddressType.home;

  @override
  void initState() {
    super.initState();
    final address = widget.address;
    titleController = TextEditingController(text: address?.title ?? '');
    addressController = TextEditingController(text: address?.address ?? '');
    landmarkController = TextEditingController(text: address?.landmark ?? '');
    areaController = TextEditingController(text: address?.area ?? '');
    cityController = TextEditingController(text: address?.city ?? '');
    stateController = TextEditingController(text: address?.state ?? '');
    pincodeController = TextEditingController(text: address?.pincode ?? '');
    phoneController = TextEditingController(text: address?.phone ?? '');
    selectedType = address?.type ?? AddressType.home;
  }

  @override
  void dispose() {
    titleController.dispose();
    addressController.dispose();
    landmarkController.dispose();
    areaController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).padding.bottom + 20,
              ),
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.address == null ? 'Add Address' : 'Edit Address',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Address Type Selection
              Text(
                'Address Type',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildTypeButton(AddressType.home, 'Home', Icons.home),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTypeButton(AddressType.office, 'Office', Icons.work),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTypeButton(AddressType.other, 'Other', Icons.location_on),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Title
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Address Title',
                  hintText: 'e.g., Home, Office',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Address
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'House/Flat/Office No.',
                  hintText: 'Enter complete address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Landmark
              TextFormField(
                controller: landmarkController,
                decoration: InputDecoration(
                  labelText: 'Landmark',
                  hintText: 'e.g., Near poplurar place',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Area
              TextFormField(
                controller: areaController,
                decoration: InputDecoration(
                  labelText: 'Area/Locality',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter area';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // City and State in Row
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'City required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: stateController,
                      decoration: InputDecoration(
                        labelText: 'State',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'State required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Pincode and Phone in Row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: pincodeController,
                      decoration: InputDecoration(
                        labelText: 'Pincode',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pincode required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    widget.address == null ? 'Add Address' : 'Update Address',
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
        ),
      ),
    ),
    );
  }

  Widget _buildTypeButton(AddressType type, String title, IconData icon) {
    final isSelected = selectedType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.green.shade50 : Colors.transparent,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.green : Colors.grey.shade600,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isSelected ? Colors.green : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      widget.onSave({
        'title': titleController.text,
        'address': addressController.text,
        'landmark': landmarkController.text,
        'area': areaController.text,
        'city': cityController.text,
        'state': stateController.text,
        'pincode': pincodeController.text,
        'phone': phoneController.text,
        'type': selectedType,
      });
    }
  }
}