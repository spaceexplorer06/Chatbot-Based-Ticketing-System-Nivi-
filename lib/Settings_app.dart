import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsApp extends StatefulWidget {
  const SettingsApp({super.key});

  @override
  State<SettingsApp> createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 65),
          child: Text("Settings"),
        ),
      ),
     backgroundColor: const Color.fromARGB(255, 158, 220, 160)
    );
  }
}