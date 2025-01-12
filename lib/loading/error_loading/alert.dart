import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/bug_reporter/bug_report.dart';
import 'package:freequiz/utilities/imports/base.dart';

class ErrorLoadingAlert extends StatelessWidget {
  final String error;
  final Widget previousWidget;
  final Color? backgroundColor;
  final List<String>? argument;
  const ErrorLoadingAlert(
      {super.key, required this.error, required this.previousWidget, this.backgroundColor, this.argument});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr('$error title'),
        style: TextStyle(color: context.darkMode ? Colors.white : Colors.black),
      ),
      backgroundColor: backgroundColor,
      content: Text('$error description').tr(args: argument),
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
