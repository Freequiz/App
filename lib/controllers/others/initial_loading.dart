import 'package:freequiz/controllers/profile/profile.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/services/local_storage/database.dart';
import 'package:freequiz/services/local_storage/preferences.dart';
import 'package:freequiz/controllers/others/languages.dart';
import 'package:freequiz/controllers/user/manage.dart';

Future<void> initialLoading() async {
  await Profile.loadAccessToken();

  final List<Function> functions = [
    QuizDatabase.open,
    Languages.get,
    Profile.loadAccessToken,
    Preferences.loadAnswerLanguage,
    ManageUser.load,
    APIUsers.refresh
  ];

  await Future.wait(functions.map((functions) => functions())); //run all Functions at the same time and wait for them

  return;
}

