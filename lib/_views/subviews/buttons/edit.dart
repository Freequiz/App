import 'package:freequiz/_views/edit/edit_create_quiz/edit_quiz.dart';
import 'package:freequiz/_views/subviews/quiz_tile/edit_quiz.dart';
import 'package:freequiz/utilities/imports/base.dart';

class Edit extends StatelessWidget {
  const Edit({super.key, required this.widget});

  final EditQuizTile widget;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => edit(context, widget),
      icon: Icon(
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
