import 'package:flutter/material.dart';

const Color color1 = Color.fromARGB(255, 152, 141, 145);
const Color color2 = Color.fromARGB(255, 230, 148, 150);
const Color color3 = Color.fromARGB(255, 233, 209, 196);
const Color color4 = Color.fromARGB(255, 209, 222, 230);
const Color color5 = Color.fromARGB(255, 154, 137, 188);
const Color backgroundGray = Color.fromARGB(255, 50, 50, 50);
const Color gray60 = Color.fromARGB(255, 60, 60, 60);
const Color highlightGray = Color.fromARGB(255, 70, 70, 70);
const Color highlightWhite = Color.fromARGB(255, 205, 205, 205);
const Color white225 = Color.fromARGB(255, 225, 225, 225);
const Color backgroundWhite = Color.fromARGB(255, 235, 235, 235);
const Color textGray = Color.fromARGB(255, 40, 40, 40);

//Dark Mode
ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: color1,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: Colors.white),
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  scaffoldBackgroundColor: const Color.fromARGB(255, 40, 40, 40),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromARGB(255, 40, 40, 40),
  ),
  dialogTheme: const DialogTheme(backgroundColor: backgroundGray),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: color1),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: color4),
    ),
    hintStyle: TextStyle(color: Colors.white),
  ),
  fontFamily: 'Inter',
);

//Light Mode for weird peoples
ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: color1,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: textGray),
      displayLarge: TextStyle(color: textGray),
      displayMedium: TextStyle(color: textGray),
      bodyLarge: TextStyle(color: textGray),
      bodyMedium: TextStyle(color: textGray),
    ),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: color1),
      ),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(width: 2, color: color2)),
      hintStyle: TextStyle(color: Colors.black),
    ),
    fontFamily: 'Inter');
