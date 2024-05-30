import 'package:flutter/material.dart';

const Color grayFreequiz = Color.fromARGB(255, 152, 141, 145);
const Color roseFreequiz = Color.fromARGB(255, 230, 148, 150);
const Color yellowFreequiz = Color.fromARGB(255, 233, 209, 196);
const Color blueFreequiz = Color.fromARGB(255, 209, 222, 230);
const Color purpleFreequiz = Color.fromARGB(255, 154, 137, 188);

const Color gray40 = Color.fromARGB(255, 40, 40, 40); //used for app background and for text
const Color gray55 = Color.fromARGB(255, 55, 55, 55); //used for background elements
const Color gray60 = Color.fromARGB(255, 60, 60, 60); //middle gray
const Color gray70 = Color.fromARGB(255, 70, 70, 70); //used for highlights

const Color white235 = Color.fromARGB(255, 235, 235, 235); //used for app background and for text
const Color white225 = Color.fromARGB(255, 225, 225, 225); //middle white
const Color white205 = Color.fromARGB(255, 205, 205, 205); //used for highlights

//Dark Mode
ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: grayFreequiz,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: Colors.white),
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    displaySmall: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  scaffoldBackgroundColor: gray40,
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: gray40,
  ),
  dialogTheme: const DialogTheme(backgroundColor: gray40),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: grayFreequiz),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: blueFreequiz),
    ),
    hintStyle: TextStyle(color: Colors.white),
  ),
  fontFamily: 'Inter',
);

//Light Mode for weird peoples
ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: grayFreequiz,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: gray40),
      displayLarge: TextStyle(color: gray40),
      displayMedium: TextStyle(color: gray40),
      bodyLarge: TextStyle(color: gray40),
      bodyMedium: TextStyle(color: gray40),
    ),
    scaffoldBackgroundColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: grayFreequiz),
      ),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(width: 2, color: roseFreequiz)),
      hintStyle: TextStyle(color: Colors.black),
    ),
    fontFamily: 'Inter');
