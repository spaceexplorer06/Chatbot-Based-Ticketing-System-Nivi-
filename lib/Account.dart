import 'package:app/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(
                isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                color: Colors.black,
              ))
        ],
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 65),
          child: Text("Account"),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  child: Icon(
                    Icons.person,
                    color: Colors.green[900],
                  ),
                ),
              ),
              const Text(
                'Profile                                    ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Profile()));
                  },
                  icon: const Icon(
                    LineAwesomeIcons.angle_right_solid,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  child: Icon(
                    Icons.people_alt,
                    color: Colors.green[900],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: Text(
                  'Login with another account',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                    onPressed: null,
                    icon: Icon(
                      LineAwesomeIcons.angle_right_solid,
                      color: Colors.black,
                    )),
              )
            ],
          ),
          
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 158, 220, 160),
    );
  }
}
