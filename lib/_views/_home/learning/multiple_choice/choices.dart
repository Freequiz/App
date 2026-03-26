import 'package:freequiz/controllers/_home/learning/multiple_choice.dart';
import 'package:freequiz/controllers/quiz/question.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:provider/provider.dart';

class Choices extends StatelessWidget {
  final int i;
  final ColorFamily color;
  const Choices({
    super.key,
    required this.i,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MultipleChoiceController>(context);
    final choice = Question.choices[i];

    return GestureDetector(
      onTap: () {
        if (choice != Questionnaire.answer()) {
          controller.wrongAnswer(context, choice, i);
        } else {
          controller.rightAnswer(context, i);
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
              ? controller.answerRight[i]
                  ? greenDark
                  : color.dark
              : controller.answerRight[i]
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
