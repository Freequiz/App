import 'package:flutter_animate/flutter_animate.dart';
import 'package:freequiz/_views/edit/confirmation.dart';
import 'package:freequiz/_views/_home/home_page/switcher.dart';
import 'package:freequiz/_views/subviews/category_title.dart';
import 'package:freequiz/_views/subviews/quiz_tile/backgrounds/delete.dart';
import 'package:freequiz/_views/subviews/quiz_tile/backgrounds/dismiss.dart';
import 'package:freequiz/_views/subviews/quiz_tile/backgrounds/favorite.dart';
import 'package:freequiz/services/api/quizzes.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/loading/load_quiz_list.dart';
import 'package:freequiz/services/local_storage/database.dart';
import 'package:freequiz/controllers/quiz/manage.dart';
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

    final List<Function> functions = [removeRecent, removeFavorite, removePersonal];

    Widget listQuizMobile(int i) {
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

    Widget listQuizTablet(int i) {
      return SizedBox(
        height: 152,
        child: LoadQuizList(
          key: keys[i],
          future: listQuizzes[i],
          onDismissed: functions[i],
          background: backgrounds[i],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => onRefresh(),
      child: LayoutWidget(
        mobile: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomePageSwitcher(onTap: onTap, options: options),
            SizedBox(
              height: context.mobileLayout ? 10 : 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: [
                    listQuizMobile(0),
                    listQuizMobile(1),
                    listQuizMobile(2),
                  ],
                ),
              ),
            ),
          ],
        ),
        tablet: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            CategoryTitle(icon: Icons.history, color: rose, title: 'history'),
            listQuizTablet(0),
            const SizedBox(height: 15.0),
            CategoryTitle(icon: Icons.star_rounded, color: purple, title: 'favorite'),
            listQuizTablet(1),
            const SizedBox(height: 15.0),
            CategoryTitle(icon: Icons.person, color: beige, title: 'created quizzes'),
            listQuizTablet(2),
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
