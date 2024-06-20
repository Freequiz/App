import 'dart:convert';
import 'dart:math';
import 'package:freequiz/utilities/imports/base.dart';

class TextFieldData {
  bool shown;
  String hint;

  TextFieldData({this.shown = true, required this.hint});

  TextEditingController input = TextEditingController();
  bool error = false;
  Color color = grayFreequiz;
  bool changed = false;
  String id = createId();
  static final Random random = Random.secure();
  static String createId([int length = 32]) {
        var values = List<int>.generate(length, (i) => random.nextInt(256));
        return base64Url.encode(values);
    }
}