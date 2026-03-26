import 'dart:convert';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/base.dart';

class TextFieldData {
  bool shown;
  String hint;

  TextFieldData({this.shown = true, required this.hint});

  TextEditingController input = TextEditingController();
  bool error = false;
  Color color = grayFreequiz;

  String id = createId();

  void setError(String text) {
    input.clear();
    hint = text.tr();
    error = true;
    color = Colors.red;
  }

  void setSuccess(String text) {
    input.clear();
    hint = text.tr();
    error = false;
    color = Colors.green;
  }

  void unsetError() {
    error = false;
    color = grayFreequiz;
  }

  static final Random random = Random.secure();
  static String createId([int length = 32]) {
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }
}
