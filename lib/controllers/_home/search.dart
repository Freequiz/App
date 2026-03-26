import 'package:freequiz/services/api/quizzes.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class Search extends ChangeNotifier {
  static bool shown = false;

  static String from = 'Any';
  static String to = 'Any';
  static String mode = 'Quiz';

  static List quizzes = [];
  static List users = [];

  static bool moreQuizzes = true;
  static bool moreUsers = true;

  static int pageQuizzes = 1;
  static int pageUsers = 1;

  static String searchTerm = "";

  static Future<Map> search(String searchTerm) async {
    final futureQuizzes = APIQuizzes.search(searchTerm, pageQuizzes);
    final futureUsers = APIUsers.search(searchTerm, pageUsers);

    final quizzes = await futureQuizzes;
    final users = await futureUsers;

    if (quizzes.isNotEmpty && users.isNotEmpty) {
      if (quizzes['success'] && users['success']) {
        return {
          'success': true,
          'quizzes': quizzes,
          'users': users,
        };
      }
    }

    return {'success': false, 'error': users['message'], 'token': quizzes['token'], 'reason': quizzes['reason']};
  }

  bool pressed = false;
  bool onChanged = false;
  bool refreshChildren = false; // variable changes back and forth between true and false to refresh children
  int shownList = 0;
  int previousShownList = 0;

  final List<String> options = ['Quiz', 'User'];

  void onPressed(int i) async {
    pressed = true;
    notifyListeners();

    if (i == 0) {
      // Quizzes Search List
      Search.pageQuizzes++;
      final newQuizzes = await APIQuizzes.search(searchTerm, Search.pageQuizzes);
      Search.quizzes.addAll(newQuizzes['data']);
      Search.moreQuizzes = newQuizzes['next_page'];
    } else {
      Search.pageUsers++;
      final newUsers = await APIUsers.search(searchTerm, Search.pageUsers);
      Search.users.addAll(newUsers['data']);
      Search.moreUsers = newUsers['next_page'];
    }

    toggleRefreshChildren();
    pressed = false;
    notifyListeners();
  }

  void toggleRefreshChildren() {
    refreshChildren = !refreshChildren;
    notifyListeners();
  }

  void onTap(String value) {
    onChanged = true;
    shownList = options.indexOf(value);
    notifyListeners();
  }

  void endAnimation() {
    previousShownList = shownList;
    onChanged = false;
    notifyListeners();
  }
}
