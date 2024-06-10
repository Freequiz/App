import 'package:flutter/material.dart';
import 'package:freequiz/utilities/providers/theme.dart';
import 'package:provider/provider.dart';

extension ScreenSizeExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  bool get mobileLayout => screenSize.shortestSide < 600;
}

extension ThemeModeExtension on BuildContext {
  bool get darkMode {
    return Provider.of<ThemeProvider>(this, listen: true).darkMode;
  }
}


