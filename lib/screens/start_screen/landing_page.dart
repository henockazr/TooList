import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/screens/main_screen/dashboard.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => Dashboard(user: user),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(232, 242, 255, 1),
      body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 80, right: 64),
                      child: Text(
                        "Welcome to TooList.\nHere you can plan your task, organize it, and we'll remind you.",
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Image.asset('logo_work.png'),
                    const SizedBox(height: 40),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          surfaceTintColor: Colors.white,
                          elevation: 8,
                          fixedSize: const Size(180, 70),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('login_page');
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        )),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          surfaceTintColor: Colors.white,
                          elevation: 8,
                          fixedSize: const Size(180, 70),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('signup_page');
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        )),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }),
    );
  }
}
