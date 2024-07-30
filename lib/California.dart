import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class California extends StatefulWidget {
  const California({super.key});

  @override
  State<California> createState() => _CaliforniaState();
}

class _CaliforniaState extends State<California> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 195, 241, 197),
    );
  }
}