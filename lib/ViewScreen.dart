import 'package:app/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          }
        },
        itemBuilder: (context) {
          return const [
            PopupMenuItem(value: MenuAction.Logout, child: Text('Logout'))
          ];
        },
      ),
       
    ],
    backgroundColor: const Color.fromARGB(255, 14, 93, 14),
    ),
    drawer: Drawer(
      child: Container(
        color: const Color.fromARGB(255, 167, 235, 169),
        child: ListView(
          children: const [
            DrawerHeader(child: Center(child: Text("HELLO", style: TextStyle(fontSize: 70),)))
          ],
        ),
      ),
    ),
  
    );
  }
}
