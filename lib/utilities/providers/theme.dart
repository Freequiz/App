import 'package:flutter/foundation.dart';
import 'package:freequiz/services/local_storage/preferences.dart';

class ThemeProvider with ChangeNotifier {
  String? theme;

  bool get darkMode {
    if (theme == "Dark Mode") {
      return true;
    }
    if (theme == "Light Mode") {
      return false;
    }
    return PlatformDispatcher.instance.platformBrightness == Brightness.dark;
  }

  bool get override {
    if (theme == "Automatic") {
      return false;
    }
    return true;
  }

  void toggleTheme(String value) {
    Preferences.setTheme(value);
    theme = value;
    notifyListeners();
  }

  String getTheme() {
    return theme ?? "Automatic";
  }
}