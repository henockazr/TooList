import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toolist/screens/Todo/todo_add.dart';
import 'package:toolist/screens/budget/budget_add_page.dart';
import 'package:toolist/screens/budget/budget_list.dart';
import 'package:toolist/screens/main_screen/home_page.dart';

import '/screens/start_screen/landing_page.dart';
import '/screens/start_screen/signup_page.dart';
import '/screens/start_screen/login_page.dart';
import '/screens/start_screen/splash_screen.dart';
import '/utils/colors.dart';
import '/utils/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TooList());
}

class TooList extends StatelessWidget {
  const TooList({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TooList App',
        theme: ThemeData(
            primarySwatch: primary,
            buttonTheme: const ButtonThemeData(
                buttonColor: Colors.white, hoverColor: Colors.grey)),
        home: const BudgetListPage(),
        routes: {
          'landing_page': (context) => const LandingPage(),
          'signup_page': (context) => const SignUpPage(),
          'login_page': (context) => const LoginPage(),
          'add_budget': (context) => const BudgetPage(),
          'add_todo': (context) => const TodoPage(),
          'list_budget': (context) => const BudgetListPage(),
        });
  }
}
