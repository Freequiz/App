import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/3_bug_reporter/bug_reporter.dart';
import 'package:freequiz/others/device_info.dart';

class ErrorLoading extends StatelessWidget {
  final String error;
  const ErrorLoading({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('loading').tr(),
      ),
      body: AlertDialog(
        title: Text(
          context.tr('$error title'),
          style: TextStyle(color: DeviceInfo.darkMode ? Colors.white : Colors.black),
        ),
        content: Text(context.tr("$error description")),
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
              Navigator.of(context).pop();
            },
            child: const Text('close').tr(),
          )
        ],
      ),
    );
  }
}
