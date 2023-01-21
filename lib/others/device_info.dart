import 'package:flutter/material.dart';

class DeviceInfo {
  static double height =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  static double width =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  static Brightness brightness =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .platformBrightness;
  static bool darkMode = theme == "Dark Mode"
      ? true
      : theme == "Light Mode"
          ? false
          : brightness == Brightness.dark;
  static String theme = "Dark Mode";
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
}
