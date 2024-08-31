import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/base.dart';

class Choices extends StatelessWidget {
  final String choice;
  final Function wrongAnswer;
  final Function rightAnswer;
  final bool answerRight;
  final int i;
  final ColorFamily color;
  const Choices({
    super.key,
    required this.choice,
    required this.wrongAnswer,
    required this.rightAnswer,
    required this.answerRight,
    required this.i,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (choice != Questionnaire.answer()) {
          wrongAnswer(choice, i);
        } else {
          rightAnswer(i);
        }
      },
      child: Container(
        width: (context.screenWidth -  50) / 2,
        height: context.screenHeight / 8,
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: context.darkMode
              ? answerRight
                  ? greenDark
                  : color.dark
              : answerRight
                  ? greenLight
                  : color.light,
        ),
        child: Text(
          choice,
          maxLines: 50,
          style: fontSize(FontSize.text),
        ),
      ),
    );
  }
}
