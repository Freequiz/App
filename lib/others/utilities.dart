import 'package:flutter/material.dart';

class Space {
  static Widget width(double width) {
    return SizedBox(width: width);
  }

  static Widget height(double height) {
    return SizedBox(height: height);
  }
}

TextStyle textColor(Color color) {
  return TextStyle(color: color);
}

Widget empty() {
  return const SizedBox(height: 0, width: 0);
}
