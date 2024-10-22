import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TripPlanning extends StatefulWidget {
  const TripPlanning({super.key});

  @override
  State<TripPlanning> createState() => _TripPlanningState();
}

class _TripPlanningState extends State<TripPlanning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text("Trip Planning"),
        ),
      )
    );
  }
}