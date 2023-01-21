import 'package:flutter/material.dart';

const Color color1 = Color.fromARGB(255, 152, 141, 145);
const Color color2 = Color.fromARGB(255, 230, 148, 150);
const Color color3 = Color.fromARGB(255, 233, 209, 196);
const Color color4 = Color.fromARGB(255, 209, 222, 230);
const Color color5 = Color.fromARGB(255, 154, 137, 188);
const Color backgroundGray = Color.fromARGB(255, 50, 50, 50);
const Color highlightGray = Color.fromARGB(255, 70, 70, 70);
const Color highlightWhite = Color.fromARGB(255, 205, 205, 205);
const Color backgroundWhite = Color.fromARGB(255, 235, 235, 235);
const Color textGray = Color.fromARGB(255, 40, 40, 40);

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: color1,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Colors.white),
    headline1: TextStyle(color: Colors.white),
    headline2: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
  ),
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
  fontFamily: 'Quicksand',
);

ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: color1,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      subtitle1: TextStyle(color: textGray),
      headline1: TextStyle(color: textGray),
      headline2: TextStyle(color: textGray),
      bodyText1: TextStyle(color: textGray),
      bodyText2: TextStyle(color: textGray),
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
    fontFamily: 'Quicksand');
