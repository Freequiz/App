import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/services/local_storage/draft_storage.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';

class QuizForm {
  final title = TextFieldData(hint: 'title'.tr());
  final description = TextFieldData(hint: 'description'.tr());

  String visibility = "public";

  List<WordPair> wordPairs = [
    WordPair(key: "0"),
    WordPair(key: "1"),
    WordPair(key: "2")
  ];

  List<WordPair> destroyed = [];

  int counter = 0;
  bool error = false;

  int definitionLanguage = 1;
  int answerLanguage = 3;

  Map createMap() {
    Map<String, Map> translations = {};

    for (WordPair wordPair in wordPairs) {
      Map<String, Map> map = wordPair.toMap();
      if (wordPair.definition.input.text == "") {
        map[wordPair.key]!["_destroy"] = "1";
      }
      translations.addAll(map);
    }

    for (WordPair wordPair in destroyed) {
      Map<String, Map> map = wordPair.toMap();
      map[wordPair.key]!["_destroy"] = "1";
      translations.addAll(map);
    }

    Map map = {
      'title': title.input.value.text,
      'description': description.input.value.text,
      'visibility': visibility,
      'from': definitionLanguage.toString(),
      'to': answerLanguage.toString(),
      'translations_attributes': translations
    };

    return map;
  }

  bool emptyDefinition(int i) {
    if (wordPairs[i].definition.input.text.replaceAll(' ', '') != "") return false;
    if (wordPairs[i].answer.input.text.replaceAll(' ', '') == "") return false;
    return true;
  }

  bool emptyAnswer(int i) {
    if (wordPairs[i].answer.input.text.replaceAll(' ', '') != "") return false;
    if (wordPairs[i].definition.input.text.replaceAll(' ', '') == "") return false;
    return true;
  }

  bool empty(int i) {
    if (wordPairs[i].answer.input.text.replaceAll(' ', '') != "") return false;
    if (wordPairs[i].definition.input.text.replaceAll(' ', '') != "") return false;
    return true;
  }

  void checkForErrors() {
    error = false;
    counter = 0;

    for (var i = 0; i < wordPairs.length; i++) {
      if (emptyDefinition(i)) {
        wordPairs[i].definition.error = true;
        wordPairs[i].definition.input.clear();
        error = true;
      } else if (emptyAnswer(i)) {
        wordPairs[i].answer.error = true;
        wordPairs[i].answer.input.clear();
        error = true;
      } else if (empty(i)) {
      } else {
        counter++;
      }
    }

    if (counter < 3) {
      error = true;
    }

    if (title.input.text.replaceAll(' ', '').length < 3) {
      title.error = true;
      title.input.clear();
      error = true;
    }
  }

  void addWordPair() {
    wordPairs
        .add(WordPair(key: wordPairs.length.toString()));
  }

  void removeWordPair(int i) {
    destroyed.add(wordPairs[i]);
    wordPairs.removeAt(i);
  }

  void save({required String mode, String? id}) {
    final map = createMap();
    map['mode'] = mode;
    map['id'] = id;

    DraftStorage.saveDraft(map);
    QuizHelper.draft = map;
  }

  bool changed() {
    if (title.input.text.isNotEmpty) {
      return true;
    }
    if (description.input.text.isNotEmpty) {
      return true;
    }
    for (var i = 0; i < wordPairs.length; i++) {
      if (wordPairs[i].definition.input.text.isNotEmpty) {
        return true;
      }
      if (wordPairs[i].answer.input.text.isNotEmpty) {
        return true;
      }
    }
    return false;
  }
}

class WordPair {
  String key;
  String? id;

  final definition = TextFieldData(hint: 'definition'.tr());

  final answer = TextFieldData(hint: 'answer'.tr());

  WordPair({required this.key});

  Map<String, Map> toMap() {
    Map<String, Map> map = {
      key: {
        "word": definition.input.text,
        "translation": answer.input.text,
      }
    };

    if (id != null) {
      map[key]!['id'] = id;
    }

    return map;
  }
}
