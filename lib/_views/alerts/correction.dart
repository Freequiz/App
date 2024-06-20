import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Correction extends StatelessWidget {
  final String givenAnswer;
  final String rightAnswer;
  const Correction(
      {super.key, required this.givenAnswer, required this.rightAnswer});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: const Text('answer wrong').tr(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('right answer').tr(),
          Text(
            rightAnswer,
            style: TextStyle(fontSize: height / 32, color: Colors.green),
          ),
          SizedBox(height: height / 32),
          const Text('your answer').tr(),
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
              child: const Text('answer right').tr(),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('close').tr(),
            ),
          ],
        ),
      ],
    );
  }
}
