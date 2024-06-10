import 'package:flutter/material.dart';
import 'package:freequiz/_views/quiz_list/list.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';
import 'package:freequiz/utilities/widgets/conditional.dart';
import 'package:freequiz/utilities/widgets/space.dart';

class QuizList extends StatelessWidget {
  final List list;
  final Function onDismissed;
  final Widget background;
  const QuizList({super.key, required this.list, required this.onDismissed, required this.background});

  @override
  Widget build(BuildContext context) {
    return Conditional(
      condition: DeviceInfo.mobileLayout,
      widget: ListQuizzes(data: list, background: background, onDismissed: onDismissed),
      defaultWidget: Conditional(
        condition: list.length > 1,
        widget: Row(
          children: [
            Expanded(
              child: ListQuizzes(
                data: list,
                onDismissed: onDismissed,
                background: background,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
            Space.width(30),
            Expanded(
              child: ListQuizzes(
                data: list,
                onDismissed: onDismissed,
                background: background,
                physics: const NeverScrollableScrollPhysics(),
                n: 1,
              ),
            )
          ],
        ),
        defaultWidget: Row(
          children: [
            Space.width((context.screenWidth - 30) / 4 + 15),
            Expanded(
              child: ListQuizzes(
                data: list,
                background: background,
                onDismissed: onDismissed,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
            Space.width((context.screenWidth - 30) / 4 + 15)
          ],
        ),
      ),
    );
  }
}
