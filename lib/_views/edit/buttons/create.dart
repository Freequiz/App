import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/edit_create_quiz/create_quiz.dart';
import 'package:freequiz/utilities/imports/themes.dart';

class CreateButton extends StatelessWidget {
  final Function refresh;
  const CreateButton({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: grayFreequiz, foregroundColor: Colors.white),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return CreateQuiz(refresh: refresh);
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            context.tr('create new quiz'),
            style: buttonStyle(),
          ),
        ),
      ),
    );
  }
}
