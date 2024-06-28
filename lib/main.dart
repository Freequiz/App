import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:freequiz/utilities/imports/themes.dart';
import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/local_storage/preferences.dart';
import 'package:freequiz/router/router.dart';
import 'package:provider/provider.dart';
import 'package:freequiz/utilities/providers/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //needs to be initialized to await EasyLocalization.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Preferences.getTheme();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('de'), Locale('fr'), Locale('it')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
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

  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    themeChangeProvider.theme = Preferences.theme;
    initDeepLinks();

    super.initState();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    _navigatorKey.currentState?.pushNamed(uri.path);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => themeChangeProvider,
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, themeProvider, child) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: !themeProvider.override
                ? ThemeMode.system
                : themeProvider.darkMode
                    ? ThemeMode.dark
                    : ThemeMode.light,
            navigatorKey: _navigatorKey,
            initialRoute: "/",
            onGenerateRoute: (settings) => appRouter(settings),
          );
        },
      ),
    );
  }
}
