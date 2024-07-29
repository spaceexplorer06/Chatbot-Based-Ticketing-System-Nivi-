import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 75),
          child: Text('Profile'),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 115),
            child: Icon(Icons.person, color : Colors.black, size: 130,),
          ),
          Text(currentUser.email!, style: const TextStyle(fontSize: 20),),
          const Divider(),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 194, 244, 196),
    );
  }
}
