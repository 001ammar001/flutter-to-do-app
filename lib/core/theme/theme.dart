import 'package:flutter/material.dart';

final appTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    onPrimary: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.grey[100],
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
  ),
  datePickerTheme: const DatePickerThemeData(
    surfaceTintColor: Colors.black,
    headerBackgroundColor: Colors.black,
    todayBackgroundColor: MaterialStatePropertyAll(Colors.grey),
    todayForegroundColor: MaterialStatePropertyAll(Colors.black),
    todayBorder: BorderSide.none,
  ),
  timePickerTheme: const TimePickerThemeData(
    hourMinuteColor: Colors.black,
    hourMinuteTextColor: Colors.white,
    dialHandColor: Colors.black,
    dayPeriodTextColor: Colors.grey,
    dayPeriodColor: Colors.black,
  ),
  useMaterial3: false,
);
