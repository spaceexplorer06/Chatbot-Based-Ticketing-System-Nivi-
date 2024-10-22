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
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text("Transportation", style: TextStyle(fontSize: 20),),
          ),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Column(
                      children: [Icon(Icons.train), Text("Train")],
                    )),
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Column(
                    children: [Icon(Icons.flight), Text("Flight")],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Column(
                      children: [Icon(Icons.car_rental), Text("Car")],
                    )),
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Column(
                    children: [Icon(Icons.bus_alert), Text("Bus")],
                  )),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text("Lodging", style: TextStyle(fontSize: 20),),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                    onPressed: () {}, child:  const Column(
                      children: [Icon(Icons.hotel),
                      Text("Hotel")],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                    onPressed: () {}, child:  const Column(
                      children: [Icon(Icons.house),
                      Text("Motel")],
                    )),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text("Attractions",style: TextStyle(fontSize: 20),),
          ),
          Row(children: [
             Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                    onPressed: () {}, child:  const Column(
                      children: [Icon(Icons.park_sharp),
                      Text("Parks")],
                    )
                    ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                    onPressed: () {}, child:  const Column(
                      children: [Icon(Icons.category),
                      Text("Zoo")],
                    )),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                    onPressed: () {}, child:  const Column(
                      children: [Icon(Icons.theaters),
                      Text("Theatre")],
                    )),
                    
              )
          ],),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                child: ElevatedButton(
                    onPressed: () {}, child:  const Column(
                      children: [Icon(Icons.museum),
                      Text("Museums")],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                    onPressed: () {}, child:  const Column(
                      children: [Icon(Icons.stadium),
                      Text("Stadiums")],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: ElevatedButton(
                    onPressed: () {}, child:  const Column(
                      children: [Icon(Icons.fort),
                      Text("Sites")],
                    )),
              ),
            ],
          )
               
               
        ],
      ),
    );
  }
}
