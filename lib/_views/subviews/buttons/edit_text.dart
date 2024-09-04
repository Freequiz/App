import 'package:freequiz/_views/edit/edit_create_quiz/edit_quiz.dart';
import 'package:freequiz/loading/load_quiz.dart';
import 'package:freequiz/utilities/imports/base.dart';

class EditTextButton extends StatelessWidget {
  final String uuid;

  const EditTextButton({super.key, required this.uuid});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => edit(context),
      child: const Icon(
        Icons.edit,
        size: 24,
      ),
    );
  }

  edit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EditQuiz(
            refresh: (id) {
              if (id == null) return;
              Navigator.of(context).pop();
              loadQuiz(context: context, uuid: id);
            },
            uuid: uuid,
            openQuiz: true,
          );
        },
      ),
    );
  }
}