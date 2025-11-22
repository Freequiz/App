import 'package:freequiz/_views/subviews/quiz_tile/backgrounds/delete.dart';
import 'package:freequiz/_views/subviews/quiz_tile/backgrounds/dismiss.dart';
import 'package:freequiz/_views/subviews/quiz_tile/backgrounds/favorite.dart';
import 'package:freequiz/controllers/quiz/manage.dart';
import 'package:freequiz/services/api/quizzes.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/services/local_storage/database.dart';
import 'package:freequiz/utilities/imports/themes.dart';

class HomePageController extends ChangeNotifier {
  static int shownQuizzes = 0;
  static int previousShownQuizzes = 0;
  static bool onChanged = false;

  static final List<Future<Map>> listQuizzes = [
    ManageQuiz.loadRecent(),
    APIUsers.getFavorites(),
    APIUsers.getQuizzes(1)
  ];
  static final List<Key> keys = [const Key("h"), const Key("f"), const Key("p")];
  static final List<String> options = ['history', 'favorite', 'personal'];
  static final List<Widget> backgrounds = [
    const BackgroundDismiss(),
    const BackgroundFavorite(),
    const BackgroundDelete()
  ];

  static void removeRecent(int i, String uuid) {
    QuizDatabase.deleteQuiz(uuid);
  }

  static void removeFavorite(int i, String uuid) async {
    APIQuizzes.setQuizFavorite(uuid, false);
  }

  Future<void> onRefresh() async {
    listQuizzes[0] = ManageQuiz.loadRecent();
    listQuizzes[1] = APIUsers.getFavorites();
    listQuizzes[2] = APIUsers.getQuizzes(1);

    for (Future<Map> quizzes in listQuizzes) {
      await quizzes;
    }

    keys[0] = keys[0] == const Key("h") ? const Key("h1") : const Key("h");
    keys[1] = keys[1] == const Key("f") ? const Key("f1") : const Key("f");
    keys[2] = keys[2] == const Key("p") ? const Key("p1") : const Key("p");

    notifyListeners();
    return;
  }

  void onTap(String value) {
    onChanged = true;
    shownQuizzes = options.indexOf(value);
    notifyListeners();
  }

  void callback(int i) {
    if (i != 0) return; //only call this once
    previousShownQuizzes = shownQuizzes;
    onChanged = false;
    notifyListeners();
  }
}
