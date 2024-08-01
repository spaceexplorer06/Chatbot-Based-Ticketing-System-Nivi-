import 'package:app/Account.dart';
import 'package:app/California.dart';
import 'package:app/Home.dart';
import 'package:app/Profile.dart';
import 'package:app/Settings_app.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: const <Widget>[
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 210, 255, 211),
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Profile()));
                      },
                      icon: const Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.black,
                      ),
                    ),
                    Text(currentUser.email!),
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  "Home Page",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text(
                  "Account",
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Account()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text(
                  "Settings",
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsApp()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () async {
                  final shouldLogout = await showlogoutDialog(context);
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (_) => false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const Text(
            "Search Destination : ",
            style: TextStyle(fontSize: 25),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
          ),
          CarouselSlider(
              items: [

                SizedBox(
                  height: 300,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: const Image(
                            image: AssetImage(
                              'assets/Images/London.jpg',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      child: Text(
                        'London',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (route) => const California()));
                        },
                        icon: Icon(LineAwesomeIcons.angle_right_solid, color: Colors.black,),
                      ),
                    )
                  ],
                )
              ],
              options: CarouselOptions(
                height: 180,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ))
        ],
      ),
    );
  }
}
