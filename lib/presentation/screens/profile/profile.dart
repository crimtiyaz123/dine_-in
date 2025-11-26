import 'package:flutter/material.dart';
import 'favorites_page.dart';
import 'address_management.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController(text: "John Doe");
  TextEditingController phoneController = TextEditingController(text: "+91 9876543210");
  TextEditingController emailController = TextEditingController(text: "john.doe@email.com");
  TextEditingController addressController = TextEditingController(text: "123, Main Street, City");

  bool notificationEnabled = true; // Notification Switch State

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Profile"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Profile Photo
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.green.shade100,
                  child: Icon(Icons.person, size: 80, color: Colors.green.shade700),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green,
                    child: IconButton(
                      onPressed: () => _showImagePickerDialog(),
                      icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Stats Row - Fixed for better responsiveness
            LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: _buildStatCard("Orders", "25", Icons.shopping_bag, constraints.maxWidth),
                    ),
                    Flexible(
                      child: _buildStatCard("Favorites", "8", Icons.favorite, constraints.maxWidth),
                    ),
                    Flexible(
                      child: _buildStatCard("Reviews", "12", Icons.rate_review, constraints.maxWidth),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 25),

            // Editable Inputs
            _buildTextField("Full Name", nameController, Icons.person),
            const SizedBox(height: 15),

            _buildTextField("Email", emailController, Icons.email),
            const SizedBox(height: 15),

            _buildTextField("Phone", phoneController, Icons.phone),
            const SizedBox(height: 15),

            _buildTextField("Address", addressController, Icons.location_on),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.edit_location, color: Colors.green),
              title: const Text("Manage Addresses"),
              subtitle: const Text("Add, edit or delete delivery addresses"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddressManagementPage()),
                );
              },
            ),
            const SizedBox(height: 25),

            // Notification Switch
            SwitchListTile(
              title: const Text("Notifications"),
              secondary: const Icon(Icons.notifications_active, color: Colors.green),
              activeColor: Colors.green,
              value: notificationEnabled,
              onChanged: (value) {
                setState(() => notificationEnabled = value);
              },
            ),

            const SizedBox(height: 10),

            // Favorites Button
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.green),
              title: const Text("Favorites"),
              subtitle: const Text("View your saved restaurants and items"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritesPage()),
                );
              },
            ),

            // Customer Support Button
            ListTile(
              leading: const Icon(Icons.support_agent, color: Colors.green),
              title: const Text("Customer Support"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Customer support feature coming soon!")),
                );
              },
            ),

            const SizedBox(height: 25),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile Updated Successfully!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Save Profile",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Profile Stat UI Widget - Enhanced for better responsive design
  Widget _buildStatCard(String title, String value, IconData icon, double screenWidth) {
    return Column(
      children: [
        Icon(icon, size: screenWidth > 400 ? 28 : 24, color: Colors.green),
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth > 400 ? 20 : 18, 
            fontWeight: FontWeight.bold, 
            color: Colors.green
          ),
        ),
        Text(
          title, 
          style: TextStyle(
            color: Colors.black54, 
            fontSize: screenWidth > 400 ? 14 : 12
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Input Field UI Widget
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

  // Image Picker Popup
  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
