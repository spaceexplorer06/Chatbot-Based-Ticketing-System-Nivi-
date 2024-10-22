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
          padding: EdgeInsets.symmetric(horizontal: 55),
          child: Text('Your Profile'),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 115),
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: 130,
            ),
          ),
          Text(
            currentUser.email!,
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "NAME",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 31, 8), width: 2),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            child: ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil('edit', (route) => false);
            }, child: const Text("Edit Profile")),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 194, 244, 196),
    );
  }
}
