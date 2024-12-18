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
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profileData.name);
    emailController = TextEditingController(text: widget.profileData.email);
    phoneController = TextEditingController(text: widget.profileData.phoneNumber);
  }

  void saveProfile() {
    if (nameController.text.isEmpty || emailController.text.isEmpty || phoneController.text.isEmpty) {
      // Show snackbar for empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    // Simulating a save operation with a delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        widget.profileData.name = nameController.text;
        widget.profileData.email = emailController.text;
        widget.profileData.phoneNumber = phoneController.text;
        isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      
      Navigator.pop(context, widget.profileData); // Go back with updated profile
    });
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
        // Gradient background for better design
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.purple.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                _buildTextField(
                  controller: nameController,
                  label: "Enter Name",
                  icon: Icons.person,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: emailController,
                  label: "Enter Email Address",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: phoneController,
                  label: "Enter Phone Number",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isSaving ? null : saveProfile,  // Disable button while saving
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[700],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: isSaving
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Save", style: TextStyle(fontSize: 18)),
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
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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
