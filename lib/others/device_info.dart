import 'package:flutter/material.dart';

class DeviceInfo {
  static Brightness brightness =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .platformBrightness;
  static bool darkMode = theme == "Dark Mode"
      ? true
      : theme == "Light Mode"
          ? false
          : brightness == Brightness.dark;
  static String theme = "Automatic";
  static bool mobileLayout =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
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
  double height() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  }
  double width() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  }
}
