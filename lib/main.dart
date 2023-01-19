import 'package:freequiz/others/initial_loading.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/root_page.dart';
import 'package:freequiz/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: color1,
            foregroundColor: Colors.white,
          ),
          textTheme: TextTheme(
            subtitle1: TextStyle(color: textGray),
            headline1: TextStyle(color: textGray),
            headline2: TextStyle(color: textGray),
            bodyText1: TextStyle(color: textGray),
            bodyText2: TextStyle(color: textGray),
          ),
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: color1),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: color2)),
            hintStyle: const TextStyle(color: Colors.black),
          ),
          fontFamily: 'Quicksand'),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
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
        dialogTheme: DialogTheme(backgroundColor: backgroundGray),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: color1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: color4),
          ),
          hintStyle: const TextStyle(color: Colors.white),
        ),
        fontFamily: 'Quicksand',
      ),
      routerConfig: router,
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: initialLoading(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const RootPage();
        } else {
          return const Drawer();
        }
      },
    );
  }
}
