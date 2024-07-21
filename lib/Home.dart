import 'dart:ui';
import 'package:app/ViewScreen.dart';
import 'package:app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rive/rive.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/Home.dart';
import 'dart:developer' as devtools show log;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
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
