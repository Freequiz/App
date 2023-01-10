import 'package:flutter/material.dart';
import 'package:freequiz/others/style.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Stack(
          children: [
            Text(
              "Freequiz",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30.0,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1.0
                  ..color = textGray,
              ),
            ),
            const Text(
              "Freequiz",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.0),
            ),
          ],
        ),
        const Spacer()
      ],
    );
  }
}
