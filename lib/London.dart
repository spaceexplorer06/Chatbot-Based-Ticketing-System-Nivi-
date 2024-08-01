import 'package:app/Chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          IconButton(onPressed: null, icon: Icon(Icons.favorite,color: Color.fromARGB(255, 255, 17, 0),))
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
            )
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 195, 241, 197),
    );
  }
}
