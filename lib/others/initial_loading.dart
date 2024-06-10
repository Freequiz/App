import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/local_storage/database.dart';
import 'package:freequiz/local_storage/preferences.dart';
import 'package:freequiz/others/languages.dart';
import 'package:freequiz/user/manage.dart';

Future<void> initialLoading() async {
  final List<Function> functions = [
    QuizDatabase.open,
    Languages.get,
    Profile.loadAccessToken,
    Preferences.loadAnswerLanguage,
    Preferences.getTheme
  ];

  await Future.wait(functions.map((functions) => functions())); //run all Functions at the same time and wait for them

  APIUsers.refresh();
  ManageUser.load();

  return;
}

