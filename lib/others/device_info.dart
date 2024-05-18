import 'package:flutter/foundation.dart';

class DeviceInfo {
  static final brightness = PlatformDispatcher.instance.platformBrightness;

  static bool darkMode = theme == "Dark Mode"
      ? true
      : theme == "Light Mode"
          ? false
          : brightness == Brightness.dark;

  static String theme = "Automatic";

  static bool mobileLayout = PlatformDispatcher.instance.displays.first.size.shortestSide < 600;

  setTheme() {
    final darkMode = theme == "Dark Mode"
        ? true
        : theme == "Light Mode"
            ? false
            : brightness == Brightness.dark;
    DeviceInfo.darkMode = darkMode;
  }
  double height() {
    return PlatformDispatcher.instance.displays.first.size.height;
  }
  double width() {
    return PlatformDispatcher.instance.displays.first.size.width;
  }
}
