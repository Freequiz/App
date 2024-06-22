import 'dart:math';

import 'package:freequiz/others/utilities.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class TextPromt extends StatelessWidget {
  const TextPromt({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textSize(
        min(
          context.screenHeight / 9 / log(text.length),
          context.screenHeight / 15,
        ),
      ),
    );
  }
}
