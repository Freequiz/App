import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/main.dart';
import 'package:freequiz/utilities/imports/base.dart';


class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: !kReleaseMode && true,
      builder: (context) => EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('de'),
        Locale('fr'),
        Locale('it'),
      ],
      path: 'assets/translations',
      fallbackLocale:  Locale('en'),
      child: MyApp(),
    ),
    );
  }
}
