import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/3_bug_reporter/bug_reporter.dart';
import 'package:freequiz/utilities/imports/base.dart';

class ErrorLoadingAlert extends StatelessWidget {
  final String error;
  final Widget previousWidget;
  final Color backgroundColor;
  const ErrorLoadingAlert(
      {super.key, required this.error, required this.previousWidget, this.backgroundColor = gray55});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr('$error title'),
        style: TextStyle(color: context.darkMode ? Colors.white : Colors.black),
      ),
      backgroundColor: backgroundColor,
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
