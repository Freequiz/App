import 'package:flutter/material.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/_home/quiz_page/quiz_page.dart';
import 'package:freequiz/_home/subviews/share.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/loading/error_loading/error_loading.dart';
import 'package:freequiz/others/loading/loading_screen/loading_screen.dart';

class LoadQuiz extends StatefulWidget {
  final String uuid;
  const LoadQuiz({super.key, required this.uuid});

  @override
  State<LoadQuiz> createState() => _LoadQuizState();
}

class _LoadQuizState extends State<LoadQuiz> {
  @override
  Widget build(BuildContext context) {
    final futureMap = APIQuizzes().getQuiz(widget.uuid, false);
    return FutureBuilder<Map>(
      future: futureMap,
      builder: (context, quiz) {
        if (quiz.hasData) {
          if (quiz.data!['success']) {
            Quiz.title = quiz.data!['quiz_data']['title'];
            return LoadingScreen(
              message: "Loading Quiz",
              finishedLoading: true,
              widget: QuizPage(
                uuid: widget.uuid,
              ),
              appBar: AppBar(
                title: Text(Quiz.title),
                leading: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  ShareButton(
                    url: "https://freequiz.herokuapp.com/quiz/${widget.uuid}",
                  ),
                ],
              ),
            );
          } else {
            return ErrorLoading(
              error: quiz.data!["message"],
            );
          }
        } else if (quiz.hasError) {
          return const ErrorLoading(
            error: "other error",
          );
        }
        return LoadingScreen(
          message: "Loading Quiz",
          finishedLoading: false,
          appBar: AppBar(
            title: Text(language["Loading"]),
          ),
        );
      },
    );
  }
}
