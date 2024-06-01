import 'package:flutter/material.dart';
import 'package:freequiz/root_page.dart';
import 'others/initial_loading.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

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
