import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz_page/quiz_page.dart';
import 'package:freequiz/_views/buttons/favorite.dart';
import 'package:freequiz/_views/kebab_menu/kebab_menu.dart';
import 'package:freequiz/loading/loading.dart';
import 'package:freequiz/loading/loading_screen/view.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/quiz/manage.dart';

void loadQuiz({required BuildContext context, required String uuid}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return LoadQuiz(uuid: uuid);
  }));
}

class LoadQuiz extends StatelessWidget {
  final String uuid;
  const LoadQuiz({super.key, required this.uuid});

  toggleFavorite() {
    QuizHelper.quiz!.toggleFavorite();
  }

  @override
  Widget build(BuildContext context) {
    final futureMap = ManageQuiz.load(uuid, true);

    return FutureBuilder<Map>(
      future: futureMap,
      builder: (context, data) {
        return loading(
          data: data,
          previousWidget: this,
          widget: LoadingScreen(
            message: "Loading Quiz",
            finishedLoading: true,
            widget: QuizPage(
              uuid: uuid,
            ),
            appBar: AppBar(
              actions: [
                Favorite(
                  favorite: QuizHelper.quiz?.favorite ?? false,
                  toggleFavorite: toggleFavorite,
                ),
                KebabMenuButton(
                  url: "https://freequiz.ch/quiz/$uuid",
                  uuid: uuid,
                ),
              ],
            ),
          ),
          context: context,
          onLoad: () => QuizHelper.checkedIfMarkedWords(),
        );
      },
    );
  }
}
