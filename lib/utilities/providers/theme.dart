import 'package:flutter/foundation.dart';
import 'package:freequiz/local_storage/preferences.dart';

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

  void toggleTheme(value) {
    Preferences.setTheme(value);
    theme = value;
    notifyListeners();
  }

  String getTheme() {
    return theme ?? "Automatic";
  }
}