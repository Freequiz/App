import 'package:flutter/material.dart';
import 'package:freequiz/others/initial_loading.dart';

class ErrorPopUp extends StatelessWidget {
  const ErrorPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    return AlertDialog(
      title: Text(
        language["Not enough words"],
        style: TextStyle(color: darkMode ? Colors.white : Colors.black),
      ),
      content: Text(language["Not enough words description"]),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(language["Close"]),
        )
      ],
    );
  }
}
