import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/_home/quiz_tile.dart';
import 'package:freequiz/api/api.dart';

class ListQuiz extends StatefulWidget {
  final ScrollPhysics physics;
  final int n;
  const ListQuiz({super.key, this.physics = const ScrollPhysics(), this.n = 0});

  @override
  State<ListQuiz> createState() => _ListQuizState();
}

class _ListQuizState extends State<ListQuiz> {
  late Future<Map> futureMap;

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return ListView.separated(
      physics: widget.physics,
      itemCount: mobileLayout ? Quiz().amountUuids() : half(),
      itemBuilder: (BuildContext context, int i) {
        futureMap = getQuiz(Quiz.uuids[mobileLayout ? i : i * 2 + widget.n]);
        return FutureBuilder<Map>(
          future: futureMap,
          builder: (context, quiz) {
            if (quiz.hasData) {
              Quiz.title = quiz.data!['data']['title'];
              return QuizTile(
                data: quiz.data!['data'],
              );
            } else if (quiz.hasError) {
              return Drawer(child: Text('${quiz.error}'));
            }
            return const CircularProgressIndicator();
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
