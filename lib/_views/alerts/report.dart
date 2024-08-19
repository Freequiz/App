import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/dropdown.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ReportAlert extends StatefulWidget {
  const ReportAlert({super.key});

  @override
  State<ReportAlert> createState() => _ReportAlertState();
}

class _ReportAlertState extends State<ReportAlert> {
  String reason = "reason";
  List<String> options = ["reason", "sexual", "violence", "hate", "spam", "child_abuse", "mobbing"];
  List<DropdownMenuItem<String>> items = [];

  @override
  void initState() {
    for (String option in options) {
      items.add(
        DropdownMenuItem(
          value: option,
          child: Text(option).tr(),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr('report'),
        style: TextStyle(color: context.darkMode ? Colors.white : Colors.black),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      content: Text(
        context.tr('choose report option'),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Dropdown(
            initialValue: reason,
            items: items,
            onChanged: (value) {
              setState(() {
                reason = value!;
              });
            },
            color: blue,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                context.tr('close'),
              ),
            ),
            TextButton(
              onPressed: () {
                if (reason != "reason") {
                  APIQuizzes.report(QuizHelper.quiz!.id, reason);
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                context.tr('done'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
