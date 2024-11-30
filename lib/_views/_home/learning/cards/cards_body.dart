import 'dart:math';

import 'package:freequiz/_views/_home/learning/cards/animated_card.dart';
import 'package:freequiz/_views/subviews/progress_bar.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:material_symbols_icons/symbols.dart';

class CardsBody extends StatefulWidget {
  final Function wrong;
  final Function right;
  final Function back;
  final ColorFamily color;
  const CardsBody({
    super.key,
    required this.wrong,
    required this.right,
    required this.back,
    required this.color,
  });

  @override
  State<CardsBody> createState() => _CardsBodyState();
}

class _CardsBodyState extends State<CardsBody> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor1 =
        context.darkMode ? const Color.fromARGB(255, 46, 46, 46) : const Color.fromARGB(255, 240, 240, 240);
    final backgroundColor2 =
        context.darkMode ? const Color.fromARGB(255, 43, 43, 43) : const Color.fromARGB(255, 235, 235, 235);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProgressBar(
          amount: Questionnaire.length,
          amountLeft: Questionnaire.questions.length.toDouble(),
          color: widget.color,
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Visibility(
                    visible: Questionnaire.questions.length > 2,
                    child: Container(
                      width: context.screenWidth / 1.25 - 40,
                      margin: const EdgeInsets.only(bottom: 30.0),
                      height: context.mobileLayout ? context.screenHeight / 2 : context.screenWidth / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.screenHeight / 20),
                        color: backgroundColor2,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  Visibility(
                    visible: Questionnaire.questions.length > 1,
                    child: Container(
                      width: context.screenWidth / 1.25 - 20,
                      height: context.mobileLayout ? context.screenHeight / 2 : context.screenWidth / 2.5,
                      margin: const EdgeInsets.only(bottom: 15.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.screenHeight / 20),
                        color: backgroundColor1,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        Questionnaire.nextDefinition(),
                        style: TextStyle(
                          fontSize: min(context.screenHeight / 10 / log(Questionnaire.nextDefinition().length), context.screenHeight / 17),
                          color: context.darkMode ? gray70 : white205
                        ),
                      ),
                    ),
                  ),
                  AnimatedCard(wrong: widget.wrong, right: widget.right)
                ],
              ),
              Space.height(context.screenHeight / 16),
              SizedBox(
                width: context.screenWidth / 1.25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    button(
                      backgroundColor: context.darkMode ? redDark : redLight,
                      foregroundColor: context.darkMode ? redLight : redDark,
                      onPressed: () => widget.wrong(),
                      icon: Symbols.close,
                    ),
                    button(
                      backgroundColor: context.darkMode ? gray40 : Colors.white,
                      foregroundColor: context.darkMode ? Colors.white : gray40,
                      onPressed: () => widget.back(),
                      icon: Symbols.undo_rounded,
                    ),
                    button(
                      backgroundColor: context.darkMode ? greenDark : greenLight,
                      foregroundColor: context.darkMode ? greenLight : greenDark,
                      onPressed: () => widget.right(),
                      icon: Symbols.check,
                    ),
                  ],
                ),
              ),
              Space.height(context.screenHeight / 32),
            ],
          ),
        ),
      ],
    );
  }

  Widget button(
      {required Color backgroundColor,
      required Color foregroundColor,
      required Function onPressed,
      required IconData icon}) {
    return SizedBox(
      width: 100,
      height: 70,
      child: TextButton(
        onPressed: () => onPressed(),
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Icon(
          icon,
          color: foregroundColor,
          size: 36,
          weight: 700,
          grade: 200,
          opticalSize: 24,
        ),
      ),
    );
  }
}
