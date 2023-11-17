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

TextStyle textSize(double size) {
  return TextStyle(fontSize: size);
}

Widget conditional(bool condition, Widget widget, { Widget defaultWidget = const SizedBox() }) {
  if (condition) {
    return widget;
  }
  else {
    return defaultWidget;
  }
}
