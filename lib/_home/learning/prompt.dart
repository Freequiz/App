import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/utilities.dart';

class TextPromt extends StatelessWidget {
  const TextPromt({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textSize(DeviceInfo().height() / 8 / log(text.length)),
    );
  }
}
