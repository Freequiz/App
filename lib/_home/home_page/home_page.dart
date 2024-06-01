import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freequiz/1_edit/confirmation.dart';
import 'package:freequiz/_home/home_page/search_page/search_bar.dart' as search;
import 'package:freequiz/_views/quiz_tile/backgrounds/delete.dart';
import 'package:freequiz/_views/quiz_tile/backgrounds/dismiss.dart';
import 'package:freequiz/_views/quiz_tile/backgrounds/favorite.dart';
import 'package:freequiz/_views/switcher/switcher.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/loading/load_quiz_list.dart';
import 'package:freequiz/local_storage/database.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/manage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final opacityColor = DeviceInfo.darkMode ? gray55 : Colors.white;
  int shownQuizzes = 0;
  int previousShownQuizzes = 0;

  bool onChanged = false;

  Future<Map> recent = ManageQuiz.loadRecent();
  Future<Map> favorites = APIUsers.getFavorites();
  Future<Map> personal = APIUsers.getQuizzes(1);

  final List<String> options = ['history', 'favorite', 'personal'];

  FocusNode focusNode = FocusNode();

  Key keyHistory = const Key("h");
  Key keyFavorites = const Key("f");
  Key keyPersonal = const Key("p");

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

    return Padding(
      padding: EdgeInsets.all(DeviceInfo.mobileLayout ? 10 : 30),
      child: RefreshIndicator(
        onRefresh: () => onRefresh(),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Future.delayed(const Duration(milliseconds: 50), () {
              focusNode.unfocus();
            });
          },
          child: Column(
            children: [
              Center(
                child: search.SearchBar(
                  focusNode: focusNode,
                ),
              ),
              SizedBox(
                height: DeviceInfo.mobileLayout ? 10 : 30,
              ),
              Switcher(
                onTap: onTap,
                texts: const ["history", "favorite", "personal"],
                value: options[shownQuizzes],
                width: DeviceInfo().width() / 1.4,
                icons: const [Icon(Icons.history), Icon(Icons.star_rounded), Icon(Icons.person)],
              ),
              SizedBox(
                height: DeviceInfo.mobileLayout ? 10 : 30,
              ),
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: LoadQuizList(
                          key: keyHistory,
                          future: recent,
                          background: const BackgroundDismiss(),
                          onDismissed: removeRecent,
                        )
                            .animate(target: onChanged ? 1 : 0)
                            .moveX(begin: - DeviceInfo().width() * previousShownQuizzes, end: - DeviceInfo().width() * shownQuizzes, duration: const Duration(milliseconds: 200))
                            .callback(callback: (_) => setState(() {
                              previousShownQuizzes = shownQuizzes;
                              onChanged = false;
                            }),),
                      ),
                      Positioned.fill(
                        child: LoadQuizList(
                          key: keyFavorites,
                          future: favorites,
                          background: const BackgroundFavorite(),
                          onDismissed: removeFavorite,
                        )
                            .animate(target: onChanged ? 1 : 0)
                            .moveX(begin: DeviceInfo().width() * (1 - previousShownQuizzes), end: DeviceInfo().width() * (1 - shownQuizzes), duration: const Duration(milliseconds: 200)),
                      ),
                      Positioned.fill(
                        child: LoadQuizList(
                          key: keyPersonal,
                          future: personal,
                          background: const BackgroundDelete(),
                          onDismissed: removePersonal,
                        )
                            .animate(target: onChanged ? 1 : 0)
                            .moveX(begin: DeviceInfo().width() * (2 - previousShownQuizzes), end: DeviceInfo().width() * (2 - shownQuizzes), duration: const Duration(milliseconds: 200)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    recent = ManageQuiz.loadRecent();
    favorites = APIUsers.getFavorites();
    personal = APIUsers.getQuizzes(1);

    await recent;
    await favorites;
    await personal;

    setState(() {
      keyHistory = keyHistory == const Key("h") ? const Key("h1") : const Key("h");
      keyFavorites = keyFavorites == const Key("f") ? const Key("f1") : const Key("f");
      keyPersonal = keyPersonal == const Key("p") ? const Key("p1") : const Key("p");
    });

    return;
  }
}
