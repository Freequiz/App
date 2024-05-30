import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/cards/card.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/_views/progress_bar.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/quiz/questionnaire.dart';

import '../../../others/utilities.dart';

class CardsBody extends StatefulWidget {
  final Function wrong;
  final Function right;
  final Color color;
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
  final backgroundColor1 = DeviceInfo.darkMode
      ? const Color.fromARGB(255, 46, 46, 46)
      : const Color.fromARGB(255, 240, 240, 240);
  final backgroundColor2 = DeviceInfo.darkMode
      ? const Color.fromARGB(255, 43, 43, 43)
      : const Color.fromARGB(255, 235, 235, 235);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: ProgressBar(
            amount: Questionnaire.length,
            amountLeft: Questionnaire.questions.length.toDouble(),
          ),
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
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        width: DeviceInfo().width() / 1.25 - 40,
                        height: DeviceInfo.mobileLayout
                            ? DeviceInfo().height() / 4
                            : DeviceInfo().width() / 2.5,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(DeviceInfo().height() / 20),
                          color: backgroundColor2,
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        width: DeviceInfo().width() / 1.25 - 20,
                        height: DeviceInfo.mobileLayout
                            ? DeviceInfo().height() / 4
                            : DeviceInfo().width() / 2.5,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(DeviceInfo().height() / 20),
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
                        layoutBuilder: (widget, list) =>
                            Stack(children: [widget!, ...list]),
                        switchInCurve: Curves.easeInBack,
                        switchOutCurve: Curves.easeInBack.flipped,
                        child: Learning.showAnswer
                            ? CardWidget(key: const ValueKey(true))
                            : CardWidget(key: const ValueKey(false)),
                      ),
                    ),
                  ],
                ),
                Space.height(DeviceInfo().height() / 16),
                SizedBox(
                  width: DeviceInfo().width() / 1.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: DeviceInfo.mobileLayout
                            ? DeviceInfo().width() / 5
                            : DeviceInfo().width() / 10,
                        height: DeviceInfo.mobileLayout
                            ? DeviceInfo().width() / 5
                            : DeviceInfo().width() / 10,
                        child: FloatingActionButton(
                          heroTag: "wrong",
                          onPressed: () {
                            widget.wrong();
                          },
                          backgroundColor: Colors.red,
                          child: const Icon(Icons.close),
                        ),
                      ),
                      SizedBox(
                        width: DeviceInfo.mobileLayout
                            ? DeviceInfo().width() / 5
                            : DeviceInfo().width() / 10,
                        height: DeviceInfo.mobileLayout
                            ? DeviceInfo().width() / 5
                            : DeviceInfo().width() / 10,
                        child: FloatingActionButton(
                          heroTag: "right",
                          onPressed: () {
                            widget.right();
                          },
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.check),
                        ),
                      ),
                    ],
                  ),
                ),
                Space.height(DeviceInfo().height() / 32),
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
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
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
}
