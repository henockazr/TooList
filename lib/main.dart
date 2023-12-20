import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toolist/screens/budget/budget_form_edit.dart';
import 'package:toolist/screens/todo/todo_add.dart';
import 'package:toolist/screens/budget/budget_add_page.dart';
import 'package:toolist/screens/budget/budget_list.dart';
import 'package:toolist/screens/todo/todo_form_edit.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TooList App',
        theme: ThemeData(
            primarySwatch: primary,
            buttonTheme: const ButtonThemeData(
                buttonColor: Colors.white, hoverColor: Colors.grey)),
        home: const SplashScreen(),
        routes: {
          'landing_page': (context) => const LandingPage(),
          'signup_page': (context) => const SignUpPage(),
          'login_page': (context) => const LoginPage(),
          'add_budget': (context) => const BudgetAddPage(),
          'list_budget': (context) => const BudgetListPage(),
          'budget_edit': (context) => const BudgetEdit(),
          'add_todo': (context) => const TodoAddPage(),
          'todo_edit': (context) => const ToDoEdit(),
        });
  }
}
