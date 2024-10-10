import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/quiz_form.dart';
import 'package:freequiz/_views/subviews/edit/add_button.dart';
import 'package:freequiz/_views/subviews/edit/counter.dart';
import 'package:freequiz/_views/subviews/edit/header.dart';
import 'package:freequiz/_views/subviews/edit/list_view.dart';
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
        Container(
          padding: EdgeInsets.only(bottom: 8, top: context.screenHeight / 100),
          alignment: Alignment.center,
          child: Text(
            context.tr("quiz automatically saved"),
            style: const TextStyle(fontSize: FontSize.secondary),
          ),
        ),
        EditHeader(
          quiz: widget.quiz,
          save: () => widget.quiz.save(mode: widget.mode),
          hintColor: hintColor,
          refresh: () => setState(() {}),
        ),
        SizedBox(
          height: context.screenHeight / 40,
        ),
        ListWordPairs(
          quiz: widget.quiz,
          mode: widget.mode,
          refresh: () => setState(() {}),
        ),
        SizedBox(
          height: context.screenHeight / 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const SizedBox(width: 70), AddButton(add: add), Counter(amount: widget.quiz.wordPairs.length)],
        )
      ],
    );
  }

  add() {
    setState(() {
      widget.quiz.addWordPair();
    });
  }
}
