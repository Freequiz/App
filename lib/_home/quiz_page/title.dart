import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/base.dart';

class QuizTitle extends StatelessWidget {
  const QuizTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: context.darkMode ? darkMainColor : lightMainColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.screenWidth / 30.4),
          topRight: Radius.circular(context.screenWidth / 30.4),
        ),
      ),
      child: Text(
        QuizHelper.quiz!.title,
        style: TextStyle(
          fontSize: context.screenHeight / 40,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
