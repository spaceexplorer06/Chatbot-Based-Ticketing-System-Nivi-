import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YourPlans extends StatefulWidget {
  const YourPlans({super.key});

  @override
  State<YourPlans> createState() => _YourPlansState();
}

class _YourPlansState extends State<YourPlans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text("Your Plans"),
        ),
      )
    );
  }
}