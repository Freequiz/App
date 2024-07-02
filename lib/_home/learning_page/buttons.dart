import 'package:freequiz/_home/learning/cards/cards.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice.dart';
import 'package:freequiz/_home/learning/smart.dart';
import 'package:freequiz/_home/learning/writing/writing.dart';
import 'package:freequiz/_home/learning_page/button.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class StartLearningButtons extends StatefulWidget {
  final int i;
  final Function refresh;

  const StartLearningButtons({super.key, required this.i, required this.refresh});

  @override
  State<StartLearningButtons> createState() => _StartLearningButtonsState();
}

class _StartLearningButtonsState extends State<StartLearningButtons> {
  late final List<Widget> pages = [const Smart(), const Writing(), const MultipleChoice(), const Cards()];

  double width = 0;
  double previousWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.mobileLayout ? context.screenHeight / 12 : 80,
      width: context.screenWidth,
      padding: const EdgeInsets.only(bottom: 20),
      color: context.darkMode ? colors[widget.i].dark : colors[widget.i].light,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StartLearningButton(i: widget.i, refresh: widget.refresh, text: 'learn'),
          Conditional(
            condition: QuizHelper.marked,
            widget: SizedBox(width: context.mobileLayout ? 10 : 15),
          ),
          Conditional(
            condition: QuizHelper.marked,
            widget: StartLearningButton(
              i: widget.i,
              refresh: widget.refresh,
              text: 'learn only',
              icon: Icons.star,
              onlyMarked: true,
            ),
          ),
        ],
      ),
    );
  }
}
