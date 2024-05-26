import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/local_storage/database.dart';
import 'package:freequiz/local_storage/preferences.dart';
import 'package:freequiz/others/languages.dart';

Future<void> initialLoading() async {
  QuizDatabase.open();
  await Languages().get();
  await Profile.loadData();
  await Preferences.loadAnswerLanguage();
  return;
}

