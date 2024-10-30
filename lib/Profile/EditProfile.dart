import 'package:app/Profile/ProfileData.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final ProfileData profileData;

  const EditProfile({super.key, required this.profileData});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profileData.name);
    emailController = TextEditingController(text: widget.profileData.email);
    phoneController = TextEditingController(text: widget.profileData.phoneNumber);
  }

  void saveProfile() {
    setState(() {
      widget.profileData.name = nameController.text;
      widget.profileData.email = emailController.text;
      widget.profileData.phoneNumber = phoneController.text;
    });
    Navigator.pop(context, widget.profileData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[600],
      ),
      body: Container(
        // Remove padding from the Container
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.purple.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Add padding here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                _buildTextField(
                  controller: nameController,
                  label: "Enter Name",
                  icon: Icons.person,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: emailController,
                  label: "Enter Email Address",
                  icon: Icons.email,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: phoneController,
                  label: "Enter Phone Number",
                  icon: Icons.phone,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[700],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Save", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.deepPurple),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple.shade300, width: 1.0),
        ),
        prefixIcon: Icon(icon, color: Colors.deepPurple),
      ),
    );
  }
}
