import 'package:flutter_animate/flutter_animate.dart';
import 'package:freequiz/1_edit/confirmation.dart';
import 'package:freequiz/_views/quiz_tile/backgrounds/delete.dart';
import 'package:freequiz/_views/quiz_tile/backgrounds/dismiss.dart';
import 'package:freequiz/_views/quiz_tile/backgrounds/favorite.dart';
import 'package:freequiz/_views/switcher/switcher.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/loading/load_quiz_list.dart';
import 'package:freequiz/local_storage/database.dart';
import 'package:freequiz/quiz/manage.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int shownQuizzes = 0;
  int previousShownQuizzes = 0;

  bool onChanged = false;

  final List<Future<Map>> listQuizzes = [ManageQuiz.loadRecent(), APIUsers.getFavorites(), APIUsers.getQuizzes(1)];
  final List<String> options = ['history', 'favorite', 'personal'];
  final List<Widget> backgrounds = [const BackgroundDismiss(), const BackgroundFavorite(), const BackgroundDelete()];
  final List<Key> keys = [const Key("h"), const Key("f"), const Key("p")];

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    onTap(String value) {
      setState(() {
        onChanged = true;
        shownQuizzes = options.indexOf(value);
      });
    }

    removeRecent(int i, String uuid) {
      QuizDatabase.deleteQuiz(uuid);
    }

    removeFavorite(int i, String uuid) async {
      APIQuizzes.setQuizFavorite(uuid, false);
    }

    removePersonal(int i, String uuid) {
      showDialog(
        context: context,
        builder: (BuildContext context) => Confirmation(refresh: () {}, uuid: uuid),
      );
    }

    Widget listQuiz(int i) {
      final List<Function> functions = [removeRecent, removeFavorite, removePersonal];

      return Positioned.fill(
        child: LoadQuizList(
          key: keys[i],
          future: listQuizzes[i],
          background: backgrounds[i],
          onDismissed: functions[i],
        )
            .animate(target: onChanged ? 1 : 0)
            .moveX(
              begin: context.screenWidth * (i - previousShownQuizzes),
              end: context.screenWidth * (i - shownQuizzes),
              duration: const Duration(milliseconds: 200),
            )
            .callback(
          callback: (_) {
            if (i != 0) return; //only call this once
            setState(() {
              previousShownQuizzes = shownQuizzes;
              onChanged = false;
            });
          },
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(context.mobileLayout ? 10 : 30),
      child: RefreshIndicator(
        onRefresh: () => onRefresh(),
        child: Column(
          children: [
            Switcher(
              onTap: onTap,
              texts: options,
              value: 'history',
              width: context.screenWidth / 1.4,
              icons: const [Icon(Icons.history), Icon(Icons.star_rounded), Icon(Icons.person)],
            ),
            SizedBox(
              height: context.mobileLayout ? 10 : 30,
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Stack(
                  children: [
                    listQuiz(0),
                    listQuiz(1),
                    listQuiz(2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    listQuizzes[0] = ManageQuiz.loadRecent();
    listQuizzes[1] = APIUsers.getFavorites();
    listQuizzes[2] = APIUsers.getQuizzes(1);

    for (Future<Map> quizzes in listQuizzes) {
      await quizzes;
    }

    setState(() {
      keys[0] = keys[0] == const Key("h") ? const Key("h1") : const Key("h");
      keys[1] = keys[1] == const Key("f") ? const Key("f1") : const Key("f");
      keys[2] = keys[2] == const Key("p") ? const Key("p1") : const Key("p");
    });

    return;
  }
}
