import 'package:freequiz/utilities/imports/base.dart';

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: darkMainColor,
    foregroundColor: Colors.white,
    scrolledUnderElevation: 0.0, //remove tint scrolling up
    titleTextStyle: TextStyle(fontSize: FontSize.title, fontWeight: FontWeight.w600),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: darkMainColor),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: darkMainColor,
    unselectedItemColor: grayFreequiz,
    selectedItemColor: Colors.white,
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: Colors.white, fontSize: FontSize.title, fontWeight: FontWeight.w600),
    displayLarge: TextStyle(color: Colors.white, fontSize: FontSize.text, fontWeight: FontWeight.w500),
    displayMedium: TextStyle(color: Colors.white, fontSize: FontSize.text, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(color: Colors.white, fontSize: FontSize.text),
    bodyMedium: TextStyle(color: Colors.white, fontSize: FontSize.text),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  scaffoldBackgroundColor: gray40,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      iconColor: Colors.white,
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: gray40,
  ),
  dialogTheme: const DialogTheme(backgroundColor: gray40),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: grayFreequiz),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: grayFreequiz),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: grayFreequiz),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: blueLight),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    hintStyle: TextStyle(
      color: Colors.white,
      fontSize: FontSize.text,
      fontWeight: FontWeight.w500,
    ),
  ),
  fontFamily: 'Inter',
);
