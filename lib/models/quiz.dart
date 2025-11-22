import 'dart:convert';
import 'package:freequiz/services/api/quizzes.dart';
import 'package:freequiz/services/local_storage/database.dart';
import 'package:freequiz/models/language.dart';
import 'package:freequiz/models/translations.dart';

class Quiz {
  Map quizData;

  String id;
  String title;
  String? description;

  String visibility;
  String creator;
  String avatarURL;

  bool favorite = false;
  bool updated = false;

  bool owner = false;

  Language from;
  Language to;

  Translations translations = Translations(translationsData: [{}], translations: []);

  Quiz({
    required this.quizData,
    required this.id,
    required this.title,
    required this.description,
    required this.visibility,
    required this.favorite,
    required this.creator,
    required this.owner,
    required this.from,
    required this.to,
    required this.translations,
    required this.avatarURL,
  });

  factory Quiz.fromJson(Map quizData) {
    final Quiz quiz = switch (quizData) {
      {
        "id": String id,
        "title": String title,
        "description": String? description,
        "visibility": String visibility,
        "created_by": String creator,
        "owner": bool owner,
        "avatar_url": String? avatarURL,
        "favorite": bool favorite,
        "from": Map from,
        "to": Map to,
        "data": List translations,
      } =>
        Quiz(
          quizData: quizData,
          id: id,
          title: title,
          description: description,
          visibility: visibility,
          creator: creator,
          favorite: favorite,
          owner: owner,
          avatarURL: avatarURL ?? "",
          from: Language.fromJson(from),
          to: Language.fromJson(to),
          translations: Translations.fromJson(translations),
        ),
      _ => throw const FormatException("Failed to load Quiz."),
    };

    if (quizData.containsKey('updated')) {
      quiz.updated = quizData['updated'];
    }
    else {
      quiz.updated = false;
    }

    return quiz;
  }

  Map<String, Object?> toMapDatabase() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "visibility": visibility,
      "created_by": creator,
      "favorite": favorite.toString(),
      "updated": updated.toString(),
      "owner": owner.toString(),
      "avatar_url": avatarURL,
      "from_language": json.encode(from.toMap()),
      "to_language": json.encode(to.toMap()),
      "data": json.encode(translations.toMap()),
      "time": DateTime.now().millisecondsSinceEpoch
    };
  }

  Map<String, Object?> toMapSync() {
    final Map<String, Object?> map = {
      "data": translations.toMapSync()
    };

    if (updated) map["favorite"] = favorite;

    return map;
  }

  Future<void> toggleFavorite() async {
    favorite = !favorite;
    updated = true;

    QuizDatabase.updateQuiz(this);
    final response = await APIQuizzes.setQuizFavorite(id, favorite);

    if (response.isEmpty) return;
    if (!response['success']) return;

    updated = false;
    QuizDatabase.updateQuiz(this);
  }

  int length() {
    return translations.translations.length;
  }
}
