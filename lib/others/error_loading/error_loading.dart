import 'package:flutter/material.dart';
import 'package:freequiz/3_bug_report/bug_reporter.dart';
import 'package:freequiz/others/initial_loading.dart';

class ErrorLoading extends StatelessWidget {
  final String error;
  const ErrorLoading({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(language["Loading"]),
      ),
      body: AlertDialog(
        title: Text(
          language["$error title"],
          style: TextStyle(color: darkMode ? Colors.white : Colors.black),
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
              Navigator.of(context).pop();
            },
            child: Text(language["Close"]),
          )
        ],
      ),
    );
  }
}
