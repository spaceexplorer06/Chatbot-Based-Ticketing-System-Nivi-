import 'package:app/Chat.dart';
import 'package:app/Viewscreen/TicketingSystem.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class London extends StatefulWidget {
  const London({super.key});

  @override
  State<London> createState() => _LondonState();
}

class _LondonState extends State<London> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: LikeButton(size: 30,
            animationDuration: Duration(milliseconds: 1000),),
          )
        ],
        flexibleSpace: const ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(250),
                bottomRight: Radius.circular(0)),
            child: Image(image: AssetImage('assets/Images/London.jpg'))),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            )),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(600))),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Join the chat :',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (route) => const Chat()));
                    },
                    icon: const Icon(
                      Icons.chat,
                      color: Colors.black,
                    ))
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Visits this month : 10.2K",
                style: TextStyle(fontSize: 25, color: Colors.blue, fontFamily: 'belanosima'),
              ),
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "TOP SIGHTS : ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            CarouselSlider(
                items: [
                  SizedBox(
                    height: 200,
                    child: Column(children: [
                      Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                            image: AssetImage('assets/Images/london1.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 240,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 200,
                    child: Column(children: [
                      Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                            image: AssetImage('assets/Images/london2.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 240,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 200,
                    child: Column(children: [
                      Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                            image: AssetImage('assets/Images/london3.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 240,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
                options: CarouselOptions(
                  height: 300,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 750),
                  viewportFraction: 0.8,
                )),
             ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (route)=> const TicketingSystem()));
                },
                child: Text(
                  "Up for a visit ?",
                style: const TextStyle(color: Colors.black),
                ),
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(252, 255, 122, 50)))),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 195, 241, 197),
    );
  }
}
