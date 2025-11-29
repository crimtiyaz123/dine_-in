

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'address_management.dart';
import '../settings/customer_support.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController =
      TextEditingController(text: "John Doe");
  TextEditingController phoneController =
      TextEditingController(text: "+91 9876543210");
  TextEditingController emailController =
      TextEditingController(text: "john.doe@email.com");
  TextEditingController addressController =
      TextEditingController(text: "123, Main Street, City");

  bool notificationEnabled = true;
  bool darkModeEnabled = false;

  // ---------------------------
  // PROFILE COMPLETION LOGIC
  // ---------------------------
  double getProfileCompletion() {
    int filled = 0;
    if (nameController.text.trim().isNotEmpty) filled++;
    if (emailController.text.trim().isNotEmpty) filled++;
    if (phoneController.text.trim().isNotEmpty) filled++;
    if (addressController.text.trim().isNotEmpty) filled++;

    return filled / 4; // 4 fields
  }

  @override
  Widget build(BuildContext context) {
    double completion = getProfileCompletion();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              darkModeEnabled ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() => darkModeEnabled = !darkModeEnabled);
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // -----------------------
            // PROFILE PICTURE
            // -----------------------
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.green.shade100,
                  child: Icon(Icons.person,
                      size: 80, color: Colors.green.shade700),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt,
                          size: 18, color: Colors.white),
                      onPressed: _showImagePickerDialog,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // -----------------------
            // PROFILE COMPLETION BAR
            // -----------------------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile Completion: ${(completion * 100).toInt()}%",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                LinearProgressIndicator(
                  value: completion,
                  minHeight: 10,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // -----------------------
            // WALLET + REWARDS CARD
            // -----------------------
          

            const SizedBox(height: 25),

            // -----------------------
            // REFERRAL SYSTEM
            // -----------------------
            _referralCard(),

            const SizedBox(height: 25),

            // -----------------------
            // QR CODE CARD
            // -----------------------
            _qrCodeCard(),

            const SizedBox(height: 25),

            // -----------------------
            // TEXT FIELDS
            // -----------------------
            _buildTextField("Full Name", nameController, Icons.person),
            const SizedBox(height: 15),

            _buildTextField("Email", emailController, Icons.email),
            const SizedBox(height: 15),

            _buildTextField("Phone", phoneController, Icons.phone),
            const SizedBox(height: 15),

            _buildTextField("Address", addressController, Icons.location_on),
            const SizedBox(height: 10),

            ListTile(
              leading: const Icon(Icons.edit_location, color: Colors.green),
              title: const Text("Manage Addresses"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddressManagementPage()));
              },
            ),

            const SizedBox(height: 25),

            SwitchListTile(
              title: const Text("Notifications"),
              secondary:
                  const Icon(Icons.notifications_active, color: Colors.green),
              value: notificationEnabled,
              onChanged: (v) {
                setState(() => notificationEnabled = v);
              },
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.support_agent, color: Colors.green),
              title: const Text("Customer Support"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => const CustomerSupportPage()));
              },
            ),

            const SizedBox(height: 25),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile Updated!")));
                },
                child: const Text("Save Profile",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  

  
  // ---------------------------
  // REFERRAL SYSTEM
  // ---------------------------
  Widget _referralCard() {
    const code = "IMT123";

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Invite & Earn ₹100",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Referral Code: IMT123",
                  style: TextStyle(fontSize: 16)),

              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(text: code));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Code copied!")),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  // ---------------------------
  // QR CODE CARD
  // ---------------------------
  
  Widget _qrCodeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Your QR Code",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Center(
            child: QrImageView(
              data: "UserID:123456",
              version: QrVersions.auto,
              size: 150,
              foregroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------
  // TEXT FIELD WIDGET
  // ---------------------------
  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 8,
        )
      ],
    );
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text("Choose Image Source"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

