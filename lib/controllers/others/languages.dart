import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:freequiz/services/api/languages.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Languages {
  static List<DropdownMenuItem<int>> languages = [];
  static Map mapLanguagesCopy = {};

  static get() async {
    final prefs = await SharedPreferences.getInstance();
    final Map mapLanguages = jsonDecode(prefs.getString('languages') ?? "{}");
    if (mapLanguages.isNotEmpty) {
      mapToList(mapLanguages);
    }
      
    load();

    mapLanguagesCopy = mapLanguages;
    return;
  }

  static load() async {
    Map mapLanguages = await httpGetLanguage();
    if (mapLanguages['success']) {
      mapToList(mapLanguages);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('languages', jsonEncode(mapLanguages));
      mapLanguagesCopy = mapLanguages;
    }
  }

  static mapToList(mapLanguages) {
    List<DropdownMenuItem<int>> newLanguages = [];
    mapLanguages['data'].forEach((key, value) {
      newLanguages.add(
        DropdownMenuItem(
          value: int.parse(key),
          child: Text(value['name'].toString().tr().capitalize()),
        ),
      );
    });
    languages = List.from(newLanguages);
  }

  idToName(int id) {
    if (id == 0) {
      return 'Any';
    }
    return mapLanguagesCopy['data'][id.toString()]['name'];
  }

  int nameToId(String name) {
    if (name == 'Any') {
      return 0;
    }

    for (String key in mapLanguagesCopy['data'].keys) {
      if (mapLanguagesCopy['data'][key]['name'] == name) {
        return int.parse(key);
      }
    }
    
    return 1;
  }
}
