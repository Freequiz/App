import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_create_quiz/edit_quiz.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/_views/quiz_tile/edit_quiz_tile.dart';

class Edit extends StatelessWidget {
  const Edit({super.key, required this.widget});

  final EditQuizTile widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => edit(context, widget),
      child: Icon(
        Icons.edit,
        color: DeviceInfo.darkMode ? Colors.white : textGray,
      ),
    );
  }

  edit(BuildContext context, EditQuizTile widget) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EditQuiz(
            refresh: widget.refresh,
            uuid: widget.uuid,
          );
        },
      ),
    );
  }
}
