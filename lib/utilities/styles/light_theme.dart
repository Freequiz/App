import 'package:freequiz/utilities/imports/base.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: lightMainColor,
    foregroundColor: gray40,
    scrolledUnderElevation: 0.0, //remove tint scrolling up
    titleTextStyle: TextStyle(fontSize: FontSize.title, fontWeight: FontWeight.w600),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: lightMainColor),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: lightMainColor,
    unselectedItemColor: gray70,
    selectedItemColor: Colors.white,
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: gray40, fontSize: FontSize.title, fontWeight: FontWeight.w600),
    displayLarge: TextStyle(color: gray40, fontSize: FontSize.text, fontWeight: FontWeight.w500),
    displayMedium: TextStyle(color: gray40, fontSize: FontSize.text, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(color: gray40, fontSize: FontSize.text),
    bodyMedium: TextStyle(color: gray40, fontSize: FontSize.text),
  ),
  scaffoldBackgroundColor: Colors.white,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      iconColor: gray40,
      foregroundColor: blueMedium,
      textStyle: buttonStyle(),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: grayFreequiz),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: roseMiddle),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    hintStyle: TextStyle(
      color: Colors.black,
      fontSize: FontSize.text,
      fontWeight: FontWeight.w500,
    ),
  ),
  fontFamily: 'Inter',
);
