import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/search_page/search_bar.dart' as search;
import 'package:freequiz/_views/quiz_list/quiz_list.dart';
import 'package:freequiz/_views/switcher/switcher.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/local_storage/quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/manage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final opacityColor = DeviceInfo.darkMode ? backgroundGray : Colors.white;
  String shownQuizzes = "history";

  Future<Map> recent = ManageQuiz.loadRecent();
  Future<Map> favorites = APIUsers.getFavorites();

  FocusNode focusNode = FocusNode();

  Key keyHistory = const Key("h");
  Key keyFavorites = const Key("f");

  @override
  Widget build(BuildContext context) {
    onTap(String value) {
      setState(() {
        shownQuizzes = value;
      });
    }

    removeRecent(int i, String uuid) {
      LocalStorage.deleteQuiz(i);
    }

    removeFavorite(int i, String uuid) async {
      APIQuizzes.setQuizFavorite(uuid, false);
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
              Center(child: search.SearchBar(focusNode: focusNode,)),
              SizedBox(
                height: DeviceInfo.mobileLayout ? 10 : 30,
              ),
              Switcher(
                onTap: onTap,
                texts: const ["history", "favorite"],
                value: shownQuizzes,
                width: DeviceInfo().width() / 3,
                icons: const [Icon(Icons.history), Icon(Icons.star_rounded)],
              ),
              SizedBox(
                height: DeviceInfo.mobileLayout ? 10 : 30,
              ),
              shownQuizzes == "history"
                  ? QuizList(
                      key: keyHistory,
                      future: recent,
                      onDismissed: removeRecent,
                    )
                  : QuizList(
                      key: keyFavorites,
                      future: favorites,
                      onDismissed: removeFavorite,
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

    await recent;
    await favorites;

    setState(() {
      keyHistory =
          keyHistory == const Key("h") ? const Key("h1") : const Key("h");
      keyFavorites =
          keyFavorites == const Key("f") ? const Key("f1") : const Key("f");
    });

    return;
  }
}
