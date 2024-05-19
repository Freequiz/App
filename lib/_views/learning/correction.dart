import 'package:flutter/material.dart';
import 'package:freequiz/others/initial_loading.dart';

class Correction extends StatelessWidget {
  final String givenAnswer;
  final String rightAnswer;
  const Correction(
      {super.key, required this.givenAnswer, required this.rightAnswer});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text(
        language["Your answer was wrong"],
      ),
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
      actions: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                language["My answer was right"],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(language["Close"]),
            ),
          ],
        ),
      ],
    );
  }
}
