import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/_home/quiz.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

Map language = {};

Future<void> initialLoading() async {
  String defaultLocale = Platform.localeName; 
  String chosenLanguage = "english";
  final prefs = await SharedPreferences.getInstance();
  Quiz.uuids = prefs.getStringList("uuids") ?? ["", "", "", "", ""];
  defaultLocale = defaultLocale.substring(0, defaultLocale.length - 3);
  if (defaultLocale == "de") {
    chosenLanguage = "german";
  }
  else if (defaultLocale == "fr") {
    chosenLanguage = "french";
  }
  final String response =
      await rootBundle.loadString('languages/$chosenLanguage.json');
  language = json.decode(response);
  await Profile().loadData();
  return;
}
