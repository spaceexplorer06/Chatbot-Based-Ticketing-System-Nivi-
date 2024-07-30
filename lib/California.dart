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
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(preferredSize: Size.fromHeight(200), child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,)),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft : Radius.circular(600))),
      ),
      backgroundColor: const Color.fromARGB(255, 195, 241, 197),
    );
  }
}