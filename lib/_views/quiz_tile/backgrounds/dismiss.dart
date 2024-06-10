import 'package:flutter/material.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';

class BackgroundDismiss extends StatelessWidget {
  const BackgroundDismiss({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.screenHeight/ 100),
        color: grayFreequiz,
      ),
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.clear_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
