import 'package:freequiz/1_edit/quiz_form.dart';
import 'package:freequiz/_views/edit/add_button.dart';
import 'package:freequiz/_views/edit/header.dart';
import 'package:freequiz/_views/edit/list_view.dart';
import 'package:freequiz/utilities/imports/base.dart';

class EditView extends StatefulWidget {
  final QuizForm quiz;
  final String mode;

  const EditView({super.key, required this.quiz, required this.mode});

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  @override
  Widget build(BuildContext context) {
    final hintColor = context.darkMode ? Colors.white : gray40;

    return ListView(
      children: [
        SizedBox(
          height: context.screenHeight / 60,
        ),
        EditHeader(quiz: widget.quiz, save: () => widget.quiz.save(mode: widget.mode), hintColor: hintColor),
        SizedBox(
          height: context.screenHeight / 40,
        ),
        ListWordPairs(
          quiz: widget.quiz,
          mode: widget.mode,
        ),
        SizedBox(
          height: context.screenHeight / 40,
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
