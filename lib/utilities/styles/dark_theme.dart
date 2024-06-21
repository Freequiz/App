import 'package:freequiz/utilities/imports/base.dart';

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
      borderSide: BorderSide(width: 2, color: blueMedium),
    ),
    hintStyle: TextStyle(color: Colors.white),
  ),
  fontFamily: 'Inter',
);