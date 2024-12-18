import 'package:app/Privacy_policy.dart';
import 'package:app/Profile.dart';
import 'package:app/Terms_conditions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>( 
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 210, 255, 189),
        title: const Text(
          'Log Out',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 220, 160),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Account',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Add theme toggle logic here if needed
            },
            icon: Icon(
              isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 240, 255, 240),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ListView(
          children: [
            // Profile Section
            _buildAccountTile(
              context,
              title: 'Profile',
              icon: Icons.person,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Profile()));
              },
            ),
            const Divider(),

            // Login with another account
            _buildAccountTile(
              context,
              title: 'Login with another account',
              icon: Icons.people_alt,
              onTap: () async {
                final shouldLogout = await showLogoutDialog(context);
                if (shouldLogout) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('/login/', (_) => false);
                }
              },
            ),
            const Divider(),

            // Theme Toggle
            SwitchListTile(
              activeColor: Colors.green,
              title: const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              value: isDark,
              onChanged: (value) {
                // Add theme toggle logic here
              },
            ),
            const Divider(),

            // Privacy Policy
            _buildAccountTile(
              context,
              title: 'Privacy Policy',
              icon: Icons.privacy_tip,
              onTap: () {
                // Navigate to Privacy Policy page
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
                );
              },
            ),
            const Divider(),

            // Terms & Conditions
            _buildAccountTile(
              context,
              title: 'Terms & Conditions',
              icon: Icons.document_scanner,
              onTap: () {
                // Navigate to Terms & Conditions page
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TermsAndConditions()),
                );
              },
            ),
            const Divider(),

            // Logout
            _buildAccountTile(
              context,
              title: 'Logout',
              icon: LineAwesomeIcons.sign_out_alt_solid,
              onTap: () async {
                final shouldLogout = await showLogoutDialog(context);
                if (shouldLogout) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('/login/', (_) => false);
                }
              },
              tileColor: Colors.red[100],
              textColor: Colors.red,
              iconColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? tileColor,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      tileColor: tileColor ?? Colors.white,
      leading: Icon(icon, color: iconColor ?? Colors.green[900]),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor ?? Colors.black,
        ),
      ),
      trailing: const Icon(LineAwesomeIcons.angle_right_solid, color: Colors.black),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
