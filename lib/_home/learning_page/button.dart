import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_home/learning/cards/cards.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice.dart';
import 'package:freequiz/_home/learning/smart.dart';
import 'package:freequiz/_home/learning/writing/writing.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class StartLearningButton extends StatefulWidget {
  final int i;
  final Function refresh;

  const StartLearningButton({super.key, required this.i, required this.refresh});

  @override
  State<StartLearningButton> createState() => _StartLearningButtonState();
}

class _StartLearningButtonState extends State<StartLearningButton> {
  late final List<Widget> pages = [const Smart(), const Writing(), const MultipleChoice(), const Cards()];

  double width = 0;
  double previousWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight / 12,
      width: context.screenWidth,
      padding: const EdgeInsets.only(bottom: 20),
      color: context.darkMode ? colors[widget.i].dark : colors[widget.i].light,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Questionnaire.create(false, Learning.modes[widget.i]);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return pages[widget.i];
                    },
                  ),
                ).then(
                  (context) => Learning.stop(
                    widget.refresh,
                    QuizHelper.quiz!.id,
                    Learning.modes[widget.i],
                  ),
                );
              },
              child: Container(
                width: widthStartButton(context.screenWidth),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.screenWidth / 30),
                  color: colors[widget.i].medium,
                ),
                child: Center(
                  child: Text(
                    context.tr('learn'),
                    style: const TextStyle(
                        fontSize: FontSize.button, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              )),
          Space.width(QuizHelper.marked ? 10 : 0),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Questionnaire.create(true, Learning.modes[widget.i]);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return pages[widget.i];
                  },
                ),
              ).then(
                (context) => Learning.stop(
                  widget.refresh,
                  QuizHelper.quiz!.id,
                  Learning.modes[widget.i],
                ),
              );
            },
            child: Container(
              height: context.screenHeight / 10 - 20,
              width: QuizHelper.marked ? widthStartButton(context.screenWidth) : 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.screenWidth / 30),
                color: colors[widget.i].medium,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.tr('learn only'),
                    style: const TextStyle(
                        fontSize: FontSize.button, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Space.width(5.0),
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  widthStartButton(width) {
    return QuizHelper.marked ? (width - 50) / 2 : width - 40;
  }
}
