import 'package:flutter/material.dart';
import 'package:freequiz/3_bug_reporter/bug_reporter.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';

class ErrorLoading2 extends StatelessWidget {
  final String error;
  final Widget previousWidget;
  const ErrorLoading2(
      {super.key, required this.error, required this.previousWidget});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        language["$error title"],
        style: TextStyle(color: DeviceInfo.darkMode ? Colors.white : Colors.black),
      ),
      content: Text(language["$error description"]),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const BugReporter();
                },
              ),
            );
          },
          child: Text(language["Bug Reporter"]),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => previousWidget),
            );
          },
          child: Text(language["Try again"]),
        )
      ],
    );
  }
}
