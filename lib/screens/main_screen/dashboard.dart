import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toolist/screens/budget/budget_list.dart';
import 'package:toolist/screens/list_page.dart';
import 'package:toolist/screens/main_screen/home_page.dart';
import 'package:toolist/screens/main_screen/search_page.dart';

import '../main_screen/profile/profile_page.dart';

class Dashboard extends StatefulWidget {
  final User user;

  const Dashboard({super.key, required this.user});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _screen = [
    const HomePage(),
    const ListPage(),
    const SearchPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('TooList',
            style:
                GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFFEAF2FF),
      ),
      body: _screen.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFEAF2FF),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: onTabTapped),
    );
  }
}
