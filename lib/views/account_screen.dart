import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laptop_store/services/auth_service.dart';
import 'package:laptop_store/views/login_screen.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  late TextEditingController _nameController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "John Doe");
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick image'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildProfilePicture() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: const Color(0xff0077B6),
            backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
            child: _imageFile == null
                ? const Icon(Icons.person, size: 60, color: Colors.white)
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xff0077B6),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: IconButton(
                icon:
                    const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                onPressed: _pickImage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: _isEditing
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.check, color: Color(0xff0077B6)),
                    onPressed: () {
                      setState(() => _isEditing = false);
                    },
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _nameController.text,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0077B6),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xff0077B6)),
                  onPressed: () => setState(() => _isEditing = true),
                ),
              ],
            ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? const Color(0xff0077B6)),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xff0077B6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          Center(child: _buildProfilePicture()),
          _buildNameSection(),
          const SizedBox(height: 16),
          _buildMenuItem(
            icon: Icons.person_outline,
            title: 'Profile',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.shopping_bag_outlined,
            title: 'Orders',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.favorite_border,
            title: 'Wishlist',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.location_on_outlined,
            title: 'Addresses',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Logout',
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Text('Logout',
                      style: TextStyle(
                          color: Color(0xff0077B6),
                          fontWeight: FontWeight.bold)),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.grey)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                            color: Color(0xff0077B6),
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        context.read<AuthService>().signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
