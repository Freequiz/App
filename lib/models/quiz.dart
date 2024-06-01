import 'dart:convert';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/models/language.dart';
import 'package:freequiz/models/translations.dart';

class Quiz {
  Map quizData;

  String id;
  String title;
  String? description;

  String visibility;
  String creator;

  bool favorite = false;

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
  });

  factory Quiz.fromJson(Map quizData) {
    return switch (quizData) {
      {
        "id": String id,
        "title": String title,
        "description": String? description,
        "visibility": String visibility,
        "created_by": String creator,
        "owner": bool owner,
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
          from: Language.fromJson(from),
          to: Language.fromJson(to),
          translations: Translations.fromJson(translations),
        ),
      _ => throw const FormatException("Failed to load Quiz."),
    };
  }

  Map toMap() {
    return {
      "success": true,
      "quiz_data": {
        "id": id,
        "title": title,
        "description": description,
        "visibility": visibility,
        "created_by": creator,
        "favorite": favorite,
        "owner": owner,
        "from": from.toMap(),
        "to": to.toMap(),
        "data": translations.toMap()
      }
    };
  }

  Map<String, Object?> toMapDatabase() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "visibility": visibility,
      "created_by": creator,
      "favorite": favorite.toString(),
      "owner": owner.toString(),
      "from_language": json.encode(from.toMap()),
      "to_language": json.encode(to.toMap()),
      "data": json.encode(translations.toMap()),
      "time": DateTime.now().millisecondsSinceEpoch
    };
  }

  toggleFavorite() {
    favorite = !favorite;
    APIQuizzes.setQuizFavorite(id, favorite);
  }
}
