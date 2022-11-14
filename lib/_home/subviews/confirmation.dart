import 'package:flutter/material.dart';
import 'package:freequiz/others/language.dart';

class Confirmation extends StatelessWidget {
  final Function reset;
  final int i;
  const Confirmation({super.key, required this.reset, required this.i});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    return AlertDialog(
      title: Text(
        language["Delete Progress"],
        style: TextStyle(color: darkMode ? Colors.white : Colors.black),
      ),
      content: Text(language[
          "Are you sure you want to delete your progress and start over?"]),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  reset(i);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text(
                  language["Delete"],
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(language["Close"]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
