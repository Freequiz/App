import 'package:flutter/material.dart';
import 'package:freequiz/others/language.dart';

class Correction extends StatelessWidget {
  final String givenAnswer;
  final String rightAnswer;
  const Correction(
      {super.key, required this.givenAnswer, required this.rightAnswer});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    return AlertDialog(
      title: Text(language["Your answer was wrong"], style: TextStyle(color: darkMode ? Colors.white : Colors.black),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language["The right answer was:"]),
          Text(
            rightAnswer,
            style: TextStyle(fontSize: height / 32, color: Colors.green),
          ),
          SizedBox(height: height / 32),
          Text(language["But you answered:"]),
          Text(
            givenAnswer,
            style: TextStyle(fontSize: height / 32, color: Colors.red),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(language["Close"]),
        ),
      ],
    );
  }
}
