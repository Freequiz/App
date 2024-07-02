import 'package:flutter/material.dart';

class DismissButton extends StatelessWidget {
  final Function onDismissed;
  final Color color;

  const DismissButton({super.key, required this.onDismissed, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: GestureDetector(
        onTap: () => onDismissed(),
        child: Icon(
          Icons.close_rounded,
          color: color,
        ),
      ),
    );
  }
}