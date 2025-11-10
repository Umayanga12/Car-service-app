import 'package:car_service/component/Navbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController(text: 'Terracode Dev');
  final TextEditingController _emailController = TextEditingController(text: 'terracode@dev.com');
  final TextEditingController _phoneController = TextEditingController(text: '+94 77 123 4567');
  final TextEditingController _addressController = TextEditingController(text: '123 Main Street, Negombo');

  // Car details
  final TextEditingController _carModelController = TextEditingController(text: 'Toyota Corolla');
  final TextEditingController _carYearController = TextEditingController(text: '2020');
  final TextEditingController _licensePlateController = TextEditingController(text: 'ABC-1234');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _carModelController.dispose();
    _carYearController.dispose();
    _licensePlateController.dispose();
    super.dispose();
  }

  void _onNavBarTap(int index) {
    if (index == 3) return;
    final routes = ['/home', '/service', '/appointment', '/profile'];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        // Save logic here - could call API to save data
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Color(0xFF00E676),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        enabled: isEditing,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(
          color: isEditing ? Colors.white : Colors.white70,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: isEditing ? const Color(0xFF00E676) : Colors.white54,
          ),
          prefixIcon: Icon(
            icon,
            color: isEditing ? const Color(0xFF00E676) : Colors.white54,
          ),
          filled: true,
          fillColor: isEditing ? const Color(0xFF2A2A2A) : const Color(0xFF1E1E1E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF3A3A3A), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00E676), width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF00E676), size: 24),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.save : Icons.edit,
              color: const Color(0xFF00E676),
            ),
            onPressed: _toggleEdit,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header with Avatar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF00E676),
                            width: 3,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xFF2A2A2A),
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Color(0xFF00E676),
                          ),
                        ),
                      ),
                      if (isEditing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF00E676),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF1E1E1E),
                                width: 2,
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt, size: 20),
                              color: Colors.black,
                              onPressed: () {
                                // Add image picker functionality
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Photo upload feature'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _nameController.text,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _emailController.text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),

            // Profile Details Form
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Information Section
                  _buildSectionHeader('Personal Information', Icons.person_outline),
                  _buildTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    icon: Icons.person,
                  ),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildTextField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextField(
                    controller: _addressController,
                    label: 'Address',
                    icon: Icons.location_on,
                    maxLines: 2,
                  ),

                  // Vehicle Information Section
                  _buildSectionHeader('Vehicle Information', Icons.directions_car),
                  _buildOptionCard(
                    icon: Icons.directions_car,
                    title: 'Vehicle Detail',
                    subtitle: 'View your vehicle details',
                    onTap: () {
                      // Navigate to service history
                      Navigator.pushReplacementNamed(context, '/vehicaldata');
                    },
                  ),

                  const SizedBox(height: 24),

                  // Additional Options
                  _buildSectionHeader('Settings', Icons.settings),
                  _buildOptionCard(
                    icon: Icons.history,
                    title: 'Service History',
                    subtitle: 'View your past services',
                    onTap: () {
                      // Navigate to service history
                    },
                  ),
                  _buildOptionCard(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    subtitle: 'Manage notification preferences',
                    onTap: () {
                      // Navigate to notifications settings
                      Navigator.pushNamed(context, '/notification');
                    },
                  ),
                  _buildOptionCard(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'Get help with your account',
                    onTap: () {
                      // Navigate to help
                    },
                  ),
                  _buildOptionCard(
                    icon: Icons.logout,
                    title: 'Logout',
                    subtitle: 'Sign out of your account',
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                    isDestructive: true,
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3, onTap: _onNavBarTap),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive
                ? Colors.red.withOpacity(0.1)
                : const Color(0xFF00E676).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isDestructive ? Colors.red : const Color(0xFF00E676),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: isDestructive ? Colors.red : Colors.white54,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Logout',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Add logout logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: Color(0xFF00E676),
                ),
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}