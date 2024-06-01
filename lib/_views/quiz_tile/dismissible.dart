import 'package:flutter/material.dart';
import 'package:freequiz/_views/quiz_tile/backgrounds/dismiss.dart';
import 'package:freequiz/_views/quiz_tile/quiz_tile.dart';
import 'package:freequiz/others/device_info.dart';

class DismissibleQuizTile extends StatefulWidget {
  final Map quizData;
  final Function onDismissed;
  final Widget? background;
  final bool expanded;
  final Widget? button;

  const DismissibleQuizTile({super.key, required this.quizData, required this.onDismissed, this.background, this.expanded = true, this.button});

  @override
  State<DismissibleQuizTile> createState() => _DismissibleQuizTileState();
}

class _DismissibleQuizTileState extends State<DismissibleQuizTile> {
  double dismissProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: widget.background ?? const BackgroundDismiss()
        ),
        Dismissible(
          key: Key(widget.quizData['id']),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) => widget.onDismissed(widget.quizData['id']),
          onUpdate: (details) {
            setState(() {
              dismissProgress = details.progress;
            });
          },
          child: QuizTile(
            data: widget.quizData,
            uuid: widget.quizData['id'],
            expanded: widget.expanded,
            button: widget.button,
            width: DeviceInfo.mobileLayout ? DeviceInfo().width() - 20 : (DeviceInfo().width() - 90) / 2,
          ),
        ),
      ],
    );
  }
}
