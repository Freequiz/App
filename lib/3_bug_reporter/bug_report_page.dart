import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/3_bug_reporter/bug_reporter.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/utilities.dart';

class BugReportPage extends StatefulWidget {
  const BugReportPage({super.key});

  @override
  State<BugReportPage> createState() => _BugReportPageState();
}

class _BugReportPageState extends State<BugReportPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: DeviceInfo().height() / 6,
        width: DeviceInfo().width() / 1.5,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: grayFreequiz, foregroundColor: Colors.white),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const BugReporter();
                },
              ),
            );
          },
          child: Text(context.tr('report bug'), style: textSize(DeviceInfo().height() / 40),),
        ),
      ),
    );
  }
}