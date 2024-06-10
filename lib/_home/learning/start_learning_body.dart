import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/cards/cards.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice.dart';
import 'package:freequiz/_views/progress_bar.dart';
import 'package:freequiz/_home/learning/smart.dart';
import 'package:freequiz/_home/learning/writing/writing.dart';
import 'package:freequiz/models/translation.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/_home/quiz_page/word_list/word_list.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/quiz/progress.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';
import 'package:freequiz/utilities/widgets/conditional.dart';
import 'package:freequiz/utilities/widgets/space.dart';


class StartLearningBody extends StatefulWidget {
  final int i;
  final Function refresh;
  final List<String> levels;
  final String uuid;
  const StartLearningBody(
      {super.key,
      required this.i,
      required this.refresh,
      required this.levels,
      required this.uuid});

  @override
  State<StartLearningBody> createState() => _StartLearningBodyState();
}

class _StartLearningBodyState extends State<StartLearningBody> {
  final List<Color> color = [purpleFreequiz, roseFreequiz, yellowFreequiz, blueFreequiz];
  late final List<Widget> pages = [
    Smart(
      refresh: refresh,
      uuid: widget.uuid,
    ),
    Writing(refresh: refresh, uuid: widget.uuid),
    MultipleChoice(refresh: refresh, uuid: widget.uuid),
    Cards(refresh: refresh, uuid: widget.uuid)
  ];

  refresh() {
    Progress.calculate(Learning.modes[widget.i]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final color5 = DeviceInfo.darkMode
        ? gray60
        : white225;
    Progress.calculate(Learning.modes[widget.i]);
    return Column(
      children: [
        ProgressBar(
            amountLeft: QuizHelper.quiz!.translations.translations.length - Progress.amount,
            amount: QuizHelper.quiz!.translations.translations.length),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.screenWidth / 30 + 10),
            color: color5,
          ),
          height: context.screenHeight/ 10,
          width: context.screenWidth - 20.0,
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
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  height: context.screenHeight/ 10 - 20,
                  width: widthStartButton(context.screenWidth),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(context.screenWidth / 30),
                    color: color[widget.i],
                  ),
                  child: Center(
                    child: Text(
                      context.tr('learn'),
                      style: TextStyle(
                          fontSize: context.screenHeight/ 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Conditional(
                condition: QuizHelper.marked,
                widget: Space.width(10),
              ),
              Conditional(
                condition: QuizHelper.marked,
                widget: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Questionnaire.create(true, Learning.modes[widget.i]);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return pages[widget.i];
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    height: context.screenHeight/ 10 - 20,
                    width: widthStartButton(context.screenWidth),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(context.screenWidth / 30),
                      color: color[widget.i],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.tr('learn only'),
                          style: TextStyle(
                              fontSize: context.screenHeight/ 36,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
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
              ),
            ],
          ),
        ),
        Space.height(15),
        Flexible(
          fit: FlexFit.loose,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
            child: ListView.builder(
              itemCount: widget.i == 0 ? 5 : 3,
              itemBuilder: (BuildContext context, int i) {
                final progressArray = Progress.array(Learning.modes[widget.i], i);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Conditional(
                      condition: progressArray.isNotEmpty,
                      widget: Container(
                        width: (context.screenWidth - 20),
                        height: context.screenHeight/ 30,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            i < widget.levels.length ? widget.levels[i] : widget.levels.last,
                            style:
                                TextStyle(fontSize: context.screenHeight/ 40),
                          ),
                        ),
                      ),
                    ),
                    WordList(
                      list: progressArray,
                      markWord: markWord,
                      i: i,
                      color: color[widget.i],
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      width: context.screenWidth,
                    ),
                    Space.height(
                      progressArray.isNotEmpty
                          ? context.screenHeight/ 30
                          : 0,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  widthStartButton(width) {
    return QuizHelper.marked ? (width - 50) / 2 : width - 40;
  }

  markWord(Translation translation) {
    setState(() {
      translation.toggleFavorite();
    });
    QuizHelper.checkedIfMarkedWords();
    widget.refresh();
  }
}
