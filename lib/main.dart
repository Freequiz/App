import 'package:freequiz/1_edit/edit_page.dart';
import 'package:freequiz/_home/home_page/home_page.dart';
import 'package:freequiz/others/language.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/2_profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    Profile().loadData;
    return MaterialApp(
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
      home: FutureBuilder<void>(
          future: loadLanguage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const RootPage();
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = const [
    HomePage(),
    EditPage(),
    ProfilePage(),
  ];
  late List<String> namePages = ["Freequiz", "Freequiz", "Freequiz"];

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(namePages[currentPage]),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove("example");
            },
            child: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 152, 141, 145),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
        currentIndex: currentPage,
        onTap: (int index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
    /*return FutureBuilder<void>(
      future: loadLanguage(),
      builder: (context, quiz) {
        if (language.isEmpty) {
          return Drawer(
            child: Image.asset(
                    "images/icon_transparent.png",
                  ),
          );
        }
        return FutureBuilder<void>(
            future: Profile().loadData(),
            builder: (context, quiz) {
              if (Profile.sessionToken != "") {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(namePages[currentPage]),
                  ),
                  body: pages[currentPage],
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: const Color.fromARGB(255, 152, 141, 145),
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    selectedItemColor: Colors.white,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: ""),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.edit), label: ""),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person), label: ""),
                    ],
                    currentIndex: currentPage,
                    onTap: (int index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                  ),
                );
              } else if (Profile.loaded) {
                return Drawer(
                  child: SignUp(refresh: refresh),
                );
              }
              return Drawer(
                child: Image.asset(
                    "images/icon_transparent.png",
                  ),
              );
            });
      },
    );*/
  }
}
