import 'package:freequiz/utilities/imports/base.dart';

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
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: roseMiddle)),
    hintStyle: TextStyle(color: Colors.black),
  ),
  fontFamily: 'Inter',
);
