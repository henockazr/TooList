import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFFCFDFF),
  100: Color(0xFFF9FBFF),
  200: Color(0xFFF5F9FF),
  300: Color(0xFFF0F6FF),
  400: Color(0xFFEDF4FF),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFFE7F0FF),
  700: Color(0xFFE4EEFF),
  800: Color(0xFFE1ECFF),
  900: Color(0xFFDBE8FF),
});
const int _primaryPrimaryValue = 0xFFEAF2FF;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
});
const int _primaryAccentValue = 0xFFFFFFFF;
