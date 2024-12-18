import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 220, 160),
        centerTitle: true,
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions for NIVI',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 16),
              Text(
                'Effective Date: 01/01/2025',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                '1. Introduction\n\nWelcome to NIVI! These Terms and Conditions govern your use of our app and services. By accessing or using the app, you agree to comply with these terms. Please read them carefully before using our services.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '2. User Eligibility\n\nYou must be at least 18 years old to use the app. By using the app, you confirm that you meet the age requirement and have the legal capacity to enter into these terms.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '3. Account Registration\n\nTo use some of the app’s features, you will need to create an account. You agree to provide accurate, complete, and current information during the registration process. You are responsible for maintaining the confidentiality of your account and password.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '4. Use of the App\n\nYou agree to use the app for lawful purposes only. You must not use the app in any way that could harm, disable, or impair the app or interfere with other users’ use of the app.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '5. Privacy and Data Collection\n\nBy using the app, you consent to our collection, use, and sharing of your data as described in our Privacy Policy.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '6. Third-Party Services\n\nThe app may integrate with third-party services. We are not responsible for the terms and conditions or privacy practices of third-party services, and you should review those policies directly.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '7. Termination of Access\n\nWe reserve the right to suspend or terminate your access to the app if we suspect you are violating these terms or engaging in fraudulent activities.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '8. Limitation of Liability\n\nTo the maximum extent permitted by law, we are not liable for any damages or losses resulting from the use or inability to use the app, even if we have been advised of the possibility of such damages.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '9. Governing Law\n\nThese terms will be governed by and construed in accordance with the laws of INDIA. Any disputes will be resolved in the courts located in New Delhi,India.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '10. Changes to These Terms\n\nWe may update these Terms and Conditions from time to time. Any changes will be posted within the app, and the updated terms will be effective immediately upon publication.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '11. Contact Us\n\nIf you have any questions or concerns regarding these Terms and Conditions, please contact us at:\nEmail: moinakdey21@gmail.com\nPhone: 9123811801',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'By using the app, you agree to these Terms and Conditions.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
