import 'package:flutter/material.dart';
import 'package:toolist/screens/landing_page.dart';
import 'package:toolist/screens/login_page.dart';
import 'package:toolist/screens/signup_page.dart';
import 'package:toolist/screens/splash_screen.dart';
import 'package:toolist/utils/colors.dart';

void main() {
  runApp(const TooList());
}

class TooList extends StatelessWidget {
  const TooList({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TooList App',
        theme: ThemeData(
          primarySwatch: primary,
        ),
        home: const SplashScreen(),
        routes: {
          'landing_page': (context) => const LandingPage(),
          'signup_page': (context) => const SignUpPage(),
          // 'login_page': (context) => const LoginPage(),
        });
  }
}
