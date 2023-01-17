import 'package:freequiz/1_edit/edit_page.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/2_profile/signup.dart';
import 'package:freequiz/3_bug_report/bug_report_page.dart';
import 'package:freequiz/_home/home_page/home_page.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/main_app_bar.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/2_profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/style.dart';

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
          future: initialLoading(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const RootPage();
            } else {
              return const Drawer();
            }
          }),
    );
  }
}

class RootPage extends StatefulWidget {
  final int i;
  const RootPage({super.key, this.i = 0});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = const [
    HomePage(),
    EditPage(),
    BugReportPage(),
    ProfilePage(),
  ];

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    currentPage = widget.i;
    APIUsers().httpPostRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Profile.accessToken != "") {
      return Scaffold(
        appBar: AppBar(
          title: const MainAppBar(),
        ),
        body: pages[currentPage],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 152, 141, 145),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.bug_report), label: ""),
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
  }
}
