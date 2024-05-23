import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/buttons/share.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/_home/quiz_page/quiz_page.dart';
import 'package:freequiz/loading/error_loading/error_loading.dart';
import 'package:freequiz/loading/loading_screen/loading_screen.dart';
import 'package:freequiz/quiz/manage.dart';

class LoadQuiz extends StatefulWidget {
  final String uuid;
  const LoadQuiz({super.key, required this.uuid});

  @override
  State<LoadQuiz> createState() => _LoadQuizState();
}

class _LoadQuizState extends State<LoadQuiz> {
  @override
  Widget build(BuildContext context) {
    final futureMap = ManageQuiz.load(widget.uuid, false);
    return FutureBuilder<Map>(
      future: futureMap,
      builder: (context, quiz) {
        if (quiz.hasData) {
          if (quiz.data!['success']) {
            return LoadingScreen(
              message: "Loading Quiz",
              finishedLoading: true,
              widget: QuizPage(
                uuid: widget.uuid,
              ),
              appBar: AppBar(
                title: Text(QuizHelper.quiz!.title),
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
            title: const Text('Loading').tr(),
          ),
        );
      },
    );
  }
}
