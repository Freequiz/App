import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:freequiz/api/languages.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Languages {
  static List<DropdownMenuItem<int>> languages = [];

  get() async {
    final prefs = await SharedPreferences.getInstance();
    final Map mapLanguages = jsonDecode(prefs.getString('languages') ?? "{}");
    if (mapLanguages.isNotEmpty) {
      mapToList(mapLanguages);
    }
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      load();
    }
    debugPrint(mapLanguages.toString());
    return;
  }

  load() async {
    Map mapLanguages = await httpGetLanguage();
    if (mapLanguages['success']) {
      mapToList(mapLanguages);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('languages', jsonEncode(mapLanguages));
    }
  }

  mapToList(mapLanguages) {
    List<DropdownMenuItem<int>> newLanguages = [];
    mapLanguages['data'].forEach((key, value) {
      newLanguages.add(
        DropdownMenuItem(
          value: int.parse(key),
          child: Text(language[value['name']] ?? value['name'].capitalize()),
        ),
      );
    });
    languages = List.from(newLanguages);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
