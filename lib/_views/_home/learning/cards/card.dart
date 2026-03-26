import 'dart:math';

import 'package:freequiz/controllers/_home/learning/cards.dart';
import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatefulWidget {
  final Function right;
  final Function wrong;
  final Color color;
  const CardWidget({super.key, required this.right, required this.wrong, required this.color});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final ValueNotifier<Color> _textColor = ValueNotifier(Colors.white);

  @override
  void dispose() {
    _textColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Learning.showAnswer ? Questionnaire.answer() : Questionnaire.definition();
    final darkMode = context.darkMode;
    final controller = Provider.of<CardsController>(context);

    _textColor.value =
        context.darkMode ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 40, 40, 40);

    return Dismissible(
      key: ValueKey(DateTime.now().millisecondsSinceEpoch),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          widget.right();
        } else {
          widget.wrong();
        }
      },
      dismissThresholds: const {
        DismissDirection.endToStart: 0.3,
        DismissDirection.startToEnd: 0.3
      },
      movementDuration: const Duration(milliseconds: 0),
      onUpdate: (details) => _textColor.value = controller.onUpdate(details, darkMode),
      child: ValueListenableBuilder(
        valueListenable: _textColor,
        builder: (context, textColor, child) {
          return Container(
            width: context.screenWidth / 1.25,
            height: context.mobileLayout ? context.screenHeight / 2 : context.screenWidth / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.screenHeight / 20),
              color: widget.color,
            ),
            padding: const EdgeInsets.all(15.0),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: min(context.screenHeight / 9 / log(text.length), context.screenHeight / 15),
                color: _textColor.value,
              ),
            ),
          );
        },
      ),
    );
  }
}
