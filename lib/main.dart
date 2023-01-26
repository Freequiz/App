import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/router/router.dart';
import 'package:provider/provider.dart';
import 'package:freequiz/others/theme.dart';

void main() {
  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.theme =
        await themeChangeProvider.themePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, value, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: themeChangeProvider.theme == "Dark Mode" ||
                    (themeChangeProvider.theme == "Automatic" &&
                        DeviceInfo.darkMode)
                ? darkTheme
                : lightTheme,
            routerConfig: router,
          );
        },
      ),
    );
  }
}