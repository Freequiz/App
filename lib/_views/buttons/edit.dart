import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_create_quiz/edit_quiz.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/_views/quiz_tile/edit_quiz.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';

class Edit extends StatelessWidget {
  const Edit({super.key, required this.widget});

  final EditQuizTile widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => edit(context, widget),
      child: Icon(
        Icons.edit,
        color: context.darkMode ? Colors.white : gray40,
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
