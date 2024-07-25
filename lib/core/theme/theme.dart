import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primarySwatch: primaryBlack,
  scaffoldBackgroundColor: Colors.grey[100],
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
  primaryColor: Colors.black,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.blueGrey.shade300,
  ),
  datePickerTheme: const DatePickerThemeData(
    surfaceTintColor: Colors.black,
    headerBackgroundColor: Colors.black,
  ),
  timePickerTheme: const TimePickerThemeData(
    hourMinuteColor: Colors.black,
    hourMinuteTextColor: Colors.white,
    dialHandColor: Colors.black,
  ),
  useMaterial3: false,
);

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;
