import 'package:flutter/material.dart';

class DismissButton extends StatelessWidget {
  final Function onDismissed;

  const DismissButton({super.key, required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onDismissed(),
      icon: const Icon(
        Icons.close_rounded,
      ),
    );
  }
}