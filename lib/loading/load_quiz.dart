import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz_page/quiz_page.dart';
import 'package:freequiz/_home/subviews/kebab_menu/kebab_menu.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/loading/error_loading/error_loading.dart';
import 'package:freequiz/loading/loading_screen/loading_screen.dart';
import 'package:freequiz/others/string_extensions.dart';
import 'package:freequiz/quiz.dart';

loadQuiz({required BuildContext context, required String uuid}) {
  final futureMap = APIQuizzes().getQuiz(uuid, false);
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return FutureBuilder<Map>(
          future: futureMap,
          builder: (context, data) {
            if (data.hasData) {
              if (data.data!['success']) {
                Quiz.title = data.data!['quiz_data']['title'];
                return LoadingScreen(
                  message: "Loading Quiz",
                  finishedLoading: true,
                  widget: QuizPage(
                    uuid: uuid,
                  ),
                  appBar: AppBar(
                    title: Text(Quiz.title),
                    actions: [
                      KebabMenuButton(
                        url: "https://freequiz.herokuapp.com/quiz/$uuid",
                        uuid: uuid,
                      ),
                    ],
                  ),
                );
              } else {
                return ErrorLoading(
                  error: data.data!["message"],
                );
              }
            } else if (data.hasError) {
              return const ErrorLoading(
                error: "other error",
              );
            }
            return LoadingScreen(
              message: "Loading Quiz",
              finishedLoading: false,
              appBar: AppBar(
                title: Text("Loading".transl()),
              ),
            );
          },
        );
      },
    ),
  );
}
