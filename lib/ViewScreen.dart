import 'package:app/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

enum MenuAction { Logout }

class _ViewScreenState extends State<ViewScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  // edit field
  Future<void> editField(String field) async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
      PopupMenuButton<MenuAction>(
          shadowColor: const Color.fromARGB(255, 5, 1, 1),
          elevation: 20,
          color: const Color.fromARGB(255, 208, 204, 197),
          onSelected: (value) async {
            switch (value) {
              case MenuAction.Logout:
                final shouldLogout = await showlogoutDialog(context);
                if (shouldLogout) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login/', (_) => false);
                }
                ;
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem(value: MenuAction.Logout,child: Text('Logout'))
            ];
          },),
    ]));
  }
}
