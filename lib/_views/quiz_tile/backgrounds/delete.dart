import 'package:flutter/material.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';

class BackgroundDelete extends StatelessWidget {
  const BackgroundDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.screenHeight/ 100),
        color: Colors.red,
      ),
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.delete_forever_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
