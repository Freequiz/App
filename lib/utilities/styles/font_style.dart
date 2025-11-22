import 'package:flutter/material.dart';

class FontSize {
  static const double headline = 34;
  static const double title = 17;
  static const double text = 15;
  static const double secondary = 13;
  static const double captions = 13;
  static const double item = 13;
  static const double button = 17;
  static const double input = 17;
  static const double tabBar = 10;
}

TextStyle fontSize(double? size) => TextStyle(fontSize: size);
TextStyle buttonStyle() => const TextStyle(fontSize: FontSize.button, fontWeight: FontWeight.w600);
TextStyle titleStyle() => const TextStyle(fontSize: FontSize.title, fontWeight: FontWeight.w600);