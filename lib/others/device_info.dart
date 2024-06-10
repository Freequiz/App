import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeviceInfo {
  static final brightness = PlatformDispatcher.instance.platformBrightness;
  static bool darkMode = theme == "Dark Mode"
      ? true
      : theme == "Light Mode"
          ? false
          : brightness == Brightness.dark;
  static String theme = "Automatic";
  static bool mobileLayout =
      MediaQueryData.fromView(WidgetsBinding.instance.window)
              .size
              .shortestSide <
          600;
  setTheme() {
    final darkMode = theme == "Dark Mode"
        ? true
        : theme == "Light Mode"
            ? false
            : brightness == Brightness.dark;
    DeviceInfo.darkMode = darkMode;
  }
}
