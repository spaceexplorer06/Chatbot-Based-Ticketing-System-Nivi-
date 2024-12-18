import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/Profile/EditProfile.dart';
import 'package:app/Profile/ProfileData.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileData profileData = ProfileData(
      name: "Name",
      email: "you@example.com",
      phoneNumber: "123-456-7890");

  Future<void> _editProfile() async {
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfile(profileData: profileData),
      ),
    );

    if (updatedProfile != null) {
      setState(() {
        profileData = updatedProfile;
      });

      // After updating profile, save it to Firestore
      saveProfileToFirestore(updatedProfile);
    }
  }

  // Method to save profile data to Firestore
  Future<void> saveProfileToFirestore(ProfileData profile) async {
    // Get the current user ID
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Reference to the Firestore document
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    // Save or update profile data in Firestore
    await userRef.set({
      'name': profile.name,
      'email': profile.email,
      'phoneNumber': profile.phoneNumber,
    }).then((value) {
      print('Profile updated successfully');
    }).catchError((error) {
      print('Failed to update profile: $error');
    });
  }

  // Method to build a profile detail with uniform icon size
  Widget _buildProfileDetail(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.deepPurple[700],
          size: 24, // Uniform icon size
        ),
        const SizedBox(width: 10),
        Expanded( // Added Expanded to allow text to take available space
          child: Text(
            "$label: $value",
            style: const TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[600],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.purple.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.deepPurple,
              child: Icon(
                Icons.star,
                size: 70,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              profileData.name,
              style: TextStyle(
                fontSize: screenWidth * 0.07, // Responsive font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              shadowColor: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile Details",
                      style: TextStyle(
                          fontSize: screenWidth * 0.05, // Responsive font size
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    const Divider(thickness: 1.5, color: Colors.deepPurple),
                    const SizedBox(height: 10),
                    _buildProfileDetail(Icons.person, "Name", profileData.name),
                    const SizedBox(height: 10),
                    _buildProfileDetail(Icons.email, "Email", profileData.email),
                    const SizedBox(height: 10),
                    _buildProfileDetail(Icons.phone, "Phone", profileData.phoneNumber),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Make the Edit Profile button more prominent
            ElevatedButton.icon(
              onPressed: _editProfile,
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                "Edit Profile",
                style: TextStyle(color: Colors.white), // Set the text color to white
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[700],
                elevation: 8, // Add shadow effect
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.03), // Responsive padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // More rounded corners
                ),
                textStyle: TextStyle(
                    fontSize: screenWidth * 0.05, // Responsive font size
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
