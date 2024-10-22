import 'package:flutter/material.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(100.0),
          child: Text("Edit Profile"),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 8), width: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Enter Email Address",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 0, 31, 8),
                                      width: 2))),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Enter Phone Number",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 0, 31, 8),
                                      width: 2))),
                        ),
                      )
                    ],
                  ),
                ),
                const ElevatedButton(
                    onPressed: null,
                    child: Text(
                      "Save",
                      style: TextStyle(color: Color.fromARGB(225, 0, 0, 0)),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
