import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/local_storage/quizzes.dart';
import 'package:freequiz/others/languages.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initialLoading() async {
  final prefs = await SharedPreferences.getInstance();
  LocalStorage.uuids = prefs.getStringList("uuids") ?? ["", "", "", "", ""];
  await Languages().get();
  await Profile.loadData();
  return;
}

