import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/quiz_form.dart';
import 'package:freequiz/_views/edit/add_button.dart';
import 'package:freequiz/_views/edit/header.dart';
import 'package:freequiz/_views/edit/list_view.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';

class EditView extends StatefulWidget {

  final QuizForm quiz;

  const EditView({super.key, required this.quiz});

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {

   final hintColor = DeviceInfo.darkMode ? Colors.white : gray40;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: context.screenHeight/ 60,
        ),
        EditHeader(quiz: widget.quiz, save: widget.quiz.save, hintColor: hintColor),
        SizedBox(
          height: context.screenHeight/ 40,
        ),
        ListWordPairs(quiz: widget.quiz),
        SizedBox(
          height: context.screenHeight/ 40,
        ),
        AddButton(add: add)
      ],
    );
  }

  add() {
    setState(() {
      widget.quiz.addWordPair();
    });
  }
}
