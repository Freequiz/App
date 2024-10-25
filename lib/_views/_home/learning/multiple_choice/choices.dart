import 'package:freequiz/controllers/home/learning/learning.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/base.dart';

class Choices extends StatelessWidget {
  final String choice;
  final int i;
  final ColorFamily color;
  final BaseLearningController controller;
  const Choices({
    super.key,
    required this.choice,
    required this.i,
    required this.color,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (choice != Questionnaire.answer()) {
          controller.wrongAnswerMC(context, choice, i);
        } else {
          controller.rightAnswerMC(context, i);
        }
      },
      child: Container(
        width: (context.screenWidth - 50) / 2,
        height: context.screenHeight / 8,
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: context.darkMode
              ? controller.answerRightMC[i]
                  ? greenDark
                  : color.dark
              : controller.answerRightMC[i]
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
