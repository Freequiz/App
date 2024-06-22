import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_page.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/2_profile/profile_page.dart';
import 'package:freequiz/2_profile/welcome.dart';
import 'package:freequiz/3_bug_reporter/bug_report_page.dart';
import 'package:freequiz/_home/home_page/home_page.dart';
import 'package:freequiz/_home/search_page/search.dart';
import 'package:freequiz/_views/app_bar/app_bar.dart';

class RootPage extends StatefulWidget {
  final int i;
  const RootPage({super.key, this.i = 0});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final FocusNode focusNode = FocusNode();
  int currentPage = 0;

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    currentPage = widget.i;
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose(); // Clean up the focus node when the form is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      const EditPage(),
      const BugReportPage(),
      ProfilePage(refresh: refresh),
    ];

    if (Profile.accessToken != "") {
      return Scaffold(
        appBar: MainAppBar(focusNode: focusNode),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
            Search.shown = false;
          },
          child: pages[currentPage],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 152, 141, 145),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.bug_report_rounded), label: ""),
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
        child: Welcome(refresh: refresh),
      );
    }
    return const Drawer();
  }
}
