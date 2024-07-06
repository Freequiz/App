import 'package:flutter/material.dart';

class DismissButton extends StatelessWidget {
  final Function onDismissed;

  const DismissButton({super.key, required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: GestureDetector(
        onTap: () => onDismissed(),
        child: const Icon(
          Icons.close_rounded,
          size: 32,
        ),
      ),
    );
  }
}