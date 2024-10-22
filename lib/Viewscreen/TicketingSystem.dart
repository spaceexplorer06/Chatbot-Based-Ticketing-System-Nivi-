import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketingSystem extends StatefulWidget {
  const TicketingSystem({super.key});

  @override
  State<TicketingSystem> createState() => _TicketingSystemState();
}

class _TicketingSystemState extends State<TicketingSystem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text("Ticketing System"),
        ),
      )
    );
  }
}