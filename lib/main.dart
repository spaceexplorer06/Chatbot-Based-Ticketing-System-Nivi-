import 'package:app/API.dart';
import 'package:app/Account.dart';
import 'package:app/Profile.dart';
import 'package:app/ViewScreen.dart';
import 'package:app/Viewscreen/CalenderPage.dart';
import 'package:app/Viewscreen/TicketingSystem.dart';
import 'package:app/Viewscreen/TripPlanning.dart';
import 'package:app/Viewscreen/YourPlans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/Home.dart';
import 'dart:developer' as devtools show log;
import 'package:app/Settings_app.dart';

void main() {
  Gemini.init(
    apiKey: GEMINI_API_KEY, // Replace with your actual API key
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: themeNotifier.themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 210, 210),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const Home(),
      routes: {
        '/home/': (context) => const Home(),
        '/view/': (context) => const ViewScreen(),
        '/login/': (context) => const LoginScreen(),
        '/account/': (context) => const Account(),
        '/setting/': (context) => const SettingsApp(),
        '/profile/': (context) => const Profile(),
        '/edit/': (context) => const Profile(),
        '/ticket/': (context) => const TicketingSystem(),
        '/trip/': (context) => const TripPlanning(),
        '/plans/': (context) => const YourPlans(),
        '/calender/': (context) => const CalendarPage(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailcontroller;
  late final TextEditingController passwordcontroller;
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _obscuretext = true;
  bool obstext = true;
  bool _textobscure = true;
  bool textobs = true;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    emailcontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/Images/image.jpeg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: FutureBuilder(
                      future: Firebase.initializeApp(
                        options: DefaultFirebaseOptions.currentPlatform,
                      ),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            return Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 50),
                                  child: SizedBox(
                                    height: 104,
                                    width: 250,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    enableSuggestions: true,
                                    controller: _email,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Color.fromARGB(255, 0, 31, 8),
                                      ),
                                      hintText: "E M A I L",
                                      hintStyle: const TextStyle(
                                        color: Color.fromARGB(255, 0, 31, 8),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 0, 31, 8),
                                            width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _password,
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    obscureText: _obscuretext,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Color.fromARGB(255, 0, 31, 8),
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obscuretext = !_obscuretext;
                                          });
                                        },
                                        child: Icon(
                                          _obscuretext
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: const Color.fromARGB(
                                              255, 0, 31, 8),
                                        ),
                                      ),
                                      hintText: "P A S S W O R D",
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(255, 0, 31, 8)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 0, 31, 8),
                                            width: 5),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 20,
                                          color: Color.fromARGB(255, 0, 31, 8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          minimumSize: WidgetStateProperty.all(
                                              const Size(10, 60)),
                                          backgroundColor:
                                              const WidgetStatePropertyAll(
                                                  Color.fromARGB(
                                                      255, 0, 31, 8)),
                                          elevation:
                                              const WidgetStatePropertyAll(10)),
                                      onPressed: () async {
                                        final email = _email.text;
                                        final password = _password.text;
                                        try {
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: email,
                                                  password: password);
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                            '/view/',
                                            (route) => false,
                                          );
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'user-not-found') {
                                            devtools
                                                .log("Something bad happened");
                                          } else if (e.code ==
                                              'wrong-password') {
                                            devtools.log("Wrong Password");
                                          }
                                        }
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 95,
                                        ),
                                        child: Text(
                                          "Sign In",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                          ),
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Don't have an account? ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.brown[700]),
                                        ),
                                        GestureDetector(
                                          child: const Text(
                                            "Sign Up",
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onTap: () {
                                            showGeneralDialog(
                                                barrierDismissible: true,
                                                barrierLabel: "Sign up",
                                                context: context,
                                                pageBuilder:
                                                    (context, _, __) => Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        20),
                                                            child: Container(
                                                              height: 480,
                                                              decoration: const BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          241,
                                                                          255,
                                                                          236),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              30))),
                                                              child: Scaffold(
                                                                resizeToAvoidBottomInset:
                                                                    false,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                body:
                                                                    FutureBuilder(
                                                                  future: Firebase
                                                                      .initializeApp(
                                                                    options:
                                                                        DefaultFirebaseOptions
                                                                            .currentPlatform,
                                                                  ),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    switch (snapshot
                                                                        .connectionState) {
                                                                      case ConnectionState
                                                                            .done:
                                                                        return Column(
                                                                          children: [
                                                                            const Padding(
                                                                              padding: EdgeInsets.symmetric(vertical: 20),
                                                                              child: Text(
                                                                                "Sign Up",
                                                                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                                                              child: TextField(
                                                                                enableSuggestions: false,
                                                                                controller: emailcontroller,
                                                                                keyboardType: TextInputType.emailAddress,
                                                                                decoration: InputDecoration(
                                                                                  prefixIcon: const Icon(
                                                                                    Icons.email,
                                                                                    color: Color.fromARGB(255, 0, 31, 8),
                                                                                  ),
                                                                                  hintText: "E M A I L",
                                                                                  hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 31, 8)),
                                                                                  border: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    borderSide: const BorderSide(color: Colors.brown, width: 5),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                                                                              child: TextField(
                                                                                obscureText: _textobscure,
                                                                                autocorrect: false,
                                                                                enableSuggestions: false,
                                                                                controller: passwordcontroller,
                                                                                decoration: InputDecoration(
                                                                                  prefixIcon: const Icon(
                                                                                    Icons.lock,
                                                                                    color: Color.fromARGB(255, 0, 31, 8),
                                                                                  ),
                                                                                  suffixIcon: GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        _textobscure = !_textobscure;
                                                                                      });
                                                                                    },
                                                                                    child: Icon(
                                                                                      _textobscure ? Icons.visibility : Icons.visibility_off,
                                                                                      color: const Color.fromARGB(255, 0, 31, 8),
                                                                                    ),
                                                                                  ),
                                                                                  hintText: "P A S S W O R D",
                                                                                  hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 31, 8)),
                                                                                  border: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    borderSide: const BorderSide(color: Colors.brown, width: 5),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: ElevatedButton(
                                                                                  style: ButtonStyle(minimumSize: WidgetStateProperty.all(const Size(10, 60)), backgroundColor: const WidgetStatePropertyAll(Color.fromARGB(255, 0, 31, 8)), elevation: const WidgetStatePropertyAll(10)),
                                                                                  onPressed: () async {
                                                                                    final email = _email.text;
                                                                                    final password = _password.text;
                                                                                    try {
                                                                                      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                                                                                      devtools.log(userCredential.toString());
                                                                                      FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.uid).set({
                                                                                        'uid': userCredential.user!.uid,
                                                                                        'email': email, // Initially Empty Bio
                                                                                      });
                                                                                    } on FirebaseAuthException catch (e) {
                                                                                      if (e.code == 'weak-password') {
                                                                                        devtools.log("Weak Password");
                                                                                      } else if (e.code == 'email-already-in-use') {
                                                                                        devtools.log("Email is already in use");
                                                                                      } else if (e.code == 'invalid-email') {
                                                                                        devtools.log("Invalid email");
                                                                                      }
                                                                                    }
                                                                                    const SnackBar(content: Text('Loading...'));
                                                                                  },
                                                                                  child: const Padding(
                                                                                    padding: EdgeInsets.symmetric(
                                                                                      horizontal: 95,
                                                                                    ),
                                                                                    child: Text(
                                                                                      "Sign Up",
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 20,
                                                                                      ),
                                                                                    ),
                                                                                  )),
                                                                            ),
                                                                            const Padding(
                                                                              padding: EdgeInsets.symmetric(vertical: 20),
                                                                              child: Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Divider(
                                                                                      thickness: 0.5,
                                                                                      color: Color.fromARGB(255, 46, 27, 20),
                                                                                    ),
                                                                                  ),
                                                                                  Text("Or Sign Up with Email or Google"),
                                                                                  Expanded(
                                                                                    child: Divider(thickness: 0.5, color: Color.fromARGB(255, 46, 27, 20)),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            const Padding(
                                                                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 80),
                                                                              child: Row(
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.email,
                                                                                    size: 50,
                                                                                  ),
                                                                                  Icon(
                                                                                    Icons.g_mobiledata,
                                                                                    size: 70,
                                                                                  ),
                                                                                  Icon(
                                                                                    Icons.facebook,
                                                                                    size: 50,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );

                                                                      default:
                                                                        return const Center(
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                          ),
                                                                        );
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ));
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          thickness: 0.5,
                                          color:
                                              Color.fromARGB(255, 77, 44, 33),
                                        ),
                                      ),
                                      Text("Or Continue With"),
                                      Expanded(
                                          child: Divider(
                                        thickness: 0.5,
                                        color: Color.fromARGB(255, 77, 44, 33),
                                      ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 50),
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                              style: const ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                        Color.fromARGB(255, 241,
                                                            255, 236)),
                                                shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                  ),
                                                ),
                                              ),
                                              key: null,
                                              onPressed: () {},
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.g_mobiledata,
                                                  size: 50,
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ),
                                        const ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      Color.fromARGB(
                                                          255, 241, 255, 236)),
                                              shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                ),
                                              ),
                                            ),
                                            onPressed: null,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.facebook,
                                                size: 50,
                                                color: Colors.black,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          default:
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            );
                        }
                      }),
                ),
              )
            ])));
  }
}
