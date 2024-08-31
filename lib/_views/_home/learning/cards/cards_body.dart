import 'dart:math';

import 'package:freequiz/_views/_home/learning/cards/card.dart';
import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/_views/subviews/progress_bar.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:material_symbols_icons/symbols.dart';

class CardsBody extends StatefulWidget {
  final Function wrong;
  final Function right;
  final ColorFamily color;
  const CardsBody({
    super.key,
    required this.wrong,
    required this.right,
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
    final colorCardsFront =
        context.darkMode ? const Color.fromARGB(255, 50, 50, 50) : const Color.fromARGB(255, 243, 243, 243);
    final colorCardsBack =
        context.darkMode ? const Color.fromARGB(255, 54, 54, 54) : const Color.fromARGB(255, 246, 246, 246);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProgressBar(
          amount: Questionnaire.length,
          amountLeft: Questionnaire.questions.length.toDouble(),
          color: widget.color,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Container(
                        width: context.screenWidth / 1.25 - 40,
                        height: context.mobileLayout ? context.screenHeight / 2 : context.screenWidth / 2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(context.screenHeight / 20),
                          color: backgroundColor2,
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Container(
                        width: context.screenWidth / 1.25 - 20,
                        height: context.mobileLayout ? context.screenHeight / 2 : context.screenWidth / 2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(context.screenHeight / 20),
                          color: backgroundColor1,
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        Learning.showAnswer = !Learning.showAnswer;
                      }),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        transitionBuilder: transitionBuilder,
                        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
                        switchInCurve: Curves.easeInBack,
                        switchOutCurve: Curves.easeInBack.flipped,
                        child: Learning.showAnswer
                            ? CardWidget(
                                key: const ValueKey(true),
                                right: widget.right,
                                wrong: widget.wrong,
                                color: colorCardsBack,
                              )
                            : CardWidget(
                                key: const ValueKey(false),
                                right: widget.right,
                                wrong: widget.wrong,
                                color: colorCardsFront,
                              ),
                      ),
                    ),
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
        ),
      ],
    );
  }

  Widget transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(Learning.showAnswer) != widget!.key);
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: widget,
        );
      },
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
