import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: const Color.fromARGB(255, 158, 220, 160),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Privacy Policy for ',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'NIVI\n\n',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Effective Date: ',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: '01/01/2025\n\n',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Introduction\n\n',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'At ',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'NIVI',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: ', we value your privacy and are committed to protecting your personal information. This ',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: ' outlines how we collect, use, store, and share your data when you use our app and services. By using ',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'NIVI',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: ', you agree to the terms of this ',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Privacy Policy.',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: '\n\nInformation We Collect\n\n',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: '1. ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Information You Provide\n\n',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Account Information: When you create an account, we collect details such as your ',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'name, email address, phone number, and profile picture.',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: '\n\nPreferences: Any preferences or settings you configure in the app.\n\n',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: '2. ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Automatically Collected Information\n\n',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Usage Data: Information about how you interact with the app, including features accessed and time spent.\n\n',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Device Information: Information such as device type, operating system, unique device identifiers, and IP address.\n\n',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Location Data: Approximate or precise location, if you grant permission.\n\n',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: '3. ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Information from Third Parties\n\n',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Social Media: If you sign in via social media platforms, we may collect information from your social media account as per their privacy policies.\n\n',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Third-Party Integrations: Data shared by services integrated with the app, such as CRM systems or email tools.\n\n',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    // Add more sections as needed...
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
