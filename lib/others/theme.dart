import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  setTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme);
  }

  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DeviceInfo.theme = prefs.getString('theme') ?? "Dark Mode";
    return DeviceInfo.theme;
  }
}

class ThemeProvider with ChangeNotifier {
  ThemePreference themePreference = ThemePreference();
  String _theme = "Dark Mode";

  String get theme => _theme;

  set theme(String value) {
    _theme = value;
    DeviceInfo.theme = theme;
    DeviceInfo().setTheme();
    themePreference.setTheme(value);
    notifyListeners();
  }
}