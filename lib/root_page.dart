import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_page.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/2_profile/profile_page.dart';
import 'package:freequiz/2_profile/signup.dart';
import 'package:freequiz/3_bug_reporter/bug_report_page.dart';
import 'package:freequiz/_home/home_page/home_page.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/main_app_bar.dart';

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
