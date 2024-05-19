import 'package:freequiz/models/translation.dart';

class Translations {
  List translationsData;
  List<Translation> translations;

  Translations({
    required this.translationsData,
    required this.translations,
  });

  factory Translations.fromJson(List translationsData) {
    List<Translation> translations = [];

    for (Map<String, dynamic> map in translationsData) {
      translations.add(Translation.fromJson(map));
    }

    return Translations(translationsData: translationsData, translations: translations);
  }

  List<Map> toMap() {
    List<Map<String, dynamic>> map = [];

    for (Translation translation in translations) {
      map.add(translation.toMap());
    }

    return map;
  }
}
