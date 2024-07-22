import 'package:app/ViewScreen.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
Future<bool> showlogoutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 255, 237, 
            189),
            title: const Text('Log Out!'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Logout')),
            ]);
      }).then((value) => value ?? false);
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = (FirebaseAuth.instance.currentUser);
              if (user == FirebaseAuth.instance.currentUser) {
                return const LoginScreen();
              } else {
                return const ViewScreen();
              }
              default:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                );
            }
          }),
    ));
  }
}
