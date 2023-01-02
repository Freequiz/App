import 'package:flutter/material.dart';
import 'package:freequiz/others/style.dart';

class TextFieldData {
  bool shown;
  String hint;

  TextFieldData({this.shown = true, required this.hint});

  TextEditingController input = TextEditingController();
  bool error = false;
  Color color = color1;
  bool changed = false;
}