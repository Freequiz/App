import 'package:freequiz/controllers/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/base.dart';

class QuizTitle extends StatelessWidget {
  const QuizTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        QuizHelper.quiz!.title,
        style: titleStyle(),
      ),
    );
  }
}
