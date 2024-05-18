import 'package:flutter/material.dart';
import 'package:freequiz/local_storage/quizzes.dart';
import 'package:freequiz/others/string_extensions.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/_home/home_page/quiz_tile.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';

class LastQuizzes extends StatefulWidget {
  final ScrollPhysics physics;
  final int n;
  const LastQuizzes(
      {super.key, this.physics = const ScrollPhysics(), this.n = 0});

  @override
  State<LastQuizzes> createState() => _LastQuizzesState();
}

class _LastQuizzesState extends State<LastQuizzes> {
  
  final defaultMap = {
    'title': "Quiz doesn't exist title".transl(),
    'description': "Quiz doesn't exist description".transl(),
    'translations': 0,
    'from': {'name': 'null'},
    'to': {'name': 'null'}
  };
  @override
  Widget build(BuildContext context) {
    final color6 = DeviceInfo.darkMode
        ? const Color.fromARGB(255, 55, 55, 55)
        : const Color.fromARGB(255, 235, 235, 235);
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return ListView.separated(
      physics: widget.physics,
      itemCount: mobileLayout ? Quiz().amountUuids() : half(),
      itemBuilder: (BuildContext context, int i) {
        String uuid = Quiz.uuids[mobileLayout ? i : i * 2 + widget.n];
        return FutureBuilder<Map>(
          future: LocalStorage.getQuiz(uuid, true),
          builder: (context, quiz) {
            if (quiz.hasData) {
              return Dismissible(
                key: Key(Quiz.uuids[i]),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    Quiz().deleteQuiz(i);
                  });
                },
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(DeviceInfo().height() / 100),
                    color: grayFreequiz,
                  ),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.clear_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                child: QuizTile(
                  data: quiz.data!['quiz_data'] ?? defaultMap,
                  uuid: uuid,
                  width: DeviceInfo.mobileLayout
                      ? DeviceInfo().width() - 20
                      : (DeviceInfo().width() - 90) / 2,
                ),
              );
            } else if (quiz.hasError) {
              return Drawer(child: Text('${quiz.error}'));
            }
            return Container(
              height: mobileLayout
                  ? DeviceInfo().height() / 30 * 4.5 + 15
                  : DeviceInfo().height() / 30 * 4.5 + 35,
              width: DeviceInfo().width() - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
                color: color6,
              ),
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return SizedBox(
          height: mobileLayout ? 10 : 30,
        );
      },
    );
  }

  half() {
    double half = Quiz().amountUuids() / 2;
    if (half.remainder(1) != 0) {
      if (widget.n == 0) {
        return (half + 0.5).toInt();
      }
      return (half - 0.5).toInt();
    }
    return half.toInt();
  }
}
