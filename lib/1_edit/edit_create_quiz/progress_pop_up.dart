import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/created_quizzes/list_quizzes.dart';
import 'package:freequiz/local_storage/quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/utilities.dart';
import 'package:freequiz/quiz.dart';

class ProgressPopUp extends StatefulWidget {
  final String title;
  final Future<Map> response;
  final Function refresh;
  const ProgressPopUp(
      {super.key,
      required this.title,
      required this.response,
      required this.refresh});

  @override
  State<ProgressPopUp> createState() => _ProgressPopUpState();
}

class _ProgressPopUpState extends State<ProgressPopUp> {
  bool closeButton = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        language[widget.title],
        style: TextStyle(color: DeviceInfo.darkMode ? Colors.white : textGray),
      ),
      content: FutureBuilder(
        future: widget.response,
        builder: (context, data) {
          if (data.hasData) {
            if (data.data!['success']) {
              closeButton = false;
              close(data);
              return Text(
                language['Quiz saved'],
                style: const TextStyle(color: Colors.green),
              );
            }
            return Text(
              language['${data.data!['message']} description'] ??
                  language['other error description'],
            );
          }
          if (data.hasError) {
            return Text(
              language['other error description'],
            );
          }
          return const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          );
        },
      ),
      actions: [
        conditional(
          closeButton,
          TextButton(
            onPressed: closeButton ? () => Navigator.of(context).pop() : () {},
            child: Text(language['Close']),
          ),
        ),
      ],
    );
  }

  close(data) {
    final quiz = data.data!['quiz_data'];
    ListQuizzes.data.insert(0, quiz);
    LocalStorage.deleteDraft();
    QuizHelper.draft.clear();
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      widget.refresh();
    });
  }
}
