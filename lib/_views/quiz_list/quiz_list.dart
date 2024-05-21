import 'package:flutter/material.dart';
import 'package:freequiz/_views/quiz_list/list.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/utilities.dart';

class QuizList extends StatelessWidget {
  final Future<Map> future;
  final Function onDismissed;
  const QuizList({super.key, required this.future, required this.onDismissed});

  @override
  Widget build(BuildContext context) {

    debugPrint("Hello Quiz List");

    return FutureBuilder<Map>(
      future: future,
      builder: (context, data) {
        if (data.hasData) {
          final List list = data.data!['data'] as List;

          debugPrint("Hello Quiz List");
          return conditional(
            DeviceInfo.mobileLayout,
            Expanded(
              child: ListQuizzes(data: list, onDismissed: onDismissed),
            ),
            defaultWidget: conditional(
              list.length > 1,
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ListQuizzes(
                        data: list,
                        onDismissed: onDismissed,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ),
                    Space.width(30),
                    Expanded(
                      child: ListQuizzes(
                        data: list,
                        onDismissed: onDismissed,
                        physics: const NeverScrollableScrollPhysics(),
                        n: 1,
                      ),
                    )
                  ],
                ),
              ),
              defaultWidget: Expanded(
                child: Row(
                  children: [
                    Space.width((DeviceInfo().width() - 30) / 4 + 15),
                    Expanded(
                        child: ListQuizzes(
                      data: list,
                      onDismissed: onDismissed,
                      physics: const NeverScrollableScrollPhysics(),
                    )),
                    Space.width((DeviceInfo().width() - 30) / 4 + 15)
                  ],
                ),
              ),
            ),
          );
        } else if (data.hasError) {
          return Drawer(child: Text('${data.error}'));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
