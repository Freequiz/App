import 'dart:math';

import 'package:freequiz/_views/_home/learning/cards/card.dart';
import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class AnimatedCard extends StatefulWidget {
  final Function wrong;
  final Function right;
  const AnimatedCard({super.key, required this.wrong, required this.right});

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _isAnimating = false;

  @override
  Widget build(BuildContext context) {
    final colorCardsFront =
        context.darkMode ? const Color.fromARGB(255, 50, 50, 50) : const Color.fromARGB(255, 243, 243, 243);
    final colorCardsBack =
        context.darkMode ? const Color.fromARGB(255, 54, 54, 54) : const Color.fromARGB(255, 246, 246, 246);

    return GestureDetector(
      onTap: _isAnimating
          ? null
          : () {
              setState(() {
                _isAnimating = true;
                Learning.showAnswer = !Learning.showAnswer;
              });

              // Reset _isAnimating after the animation duration
              Future.delayed(const Duration(milliseconds: 350), () {
                if (mounted) {
                  setState(() {
                    _isAnimating = false;
                  });
                }
              });
            },
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
}
