import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/3_bug_reporter/bug_reporter.dart';
import 'package:freequiz/others/device_info.dart';

class ErrorLoading2 extends StatelessWidget {
  final String error;
  final Widget previousWidget;
  const ErrorLoading2(
      {super.key, required this.error, required this.previousWidget});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr('$error title'),
        style: TextStyle(color: DeviceInfo.darkMode ? Colors.white : Colors.black),
      ),
      content: Text('$error description').tr(),
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
          child: const Text('bug reporter').tr(),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => previousWidget),
            );
          },
          child: const Text('try again').tr(),
        )
      ],
    );
  }
}
