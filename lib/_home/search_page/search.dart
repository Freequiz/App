import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/api/users.dart';

class Search {
  static bool shown = false;

  static String from = 'Any';
  static String to = 'Any';
  static String mode = 'Quiz';

  static List quizzes = [];
  static List users = [];

  static int page = 1;

  static Future<Map> search(String searchTerm) async {
    final futureQuizzes = APIQuizzes.search(searchTerm, 1);
    final futureUsers = APIUsers.search(searchTerm, 1);

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

    return {'success': false, 'error': users['message']};
  }
}
