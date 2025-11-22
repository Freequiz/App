import 'package:freequiz/services/api/quizzes.dart';
import 'package:freequiz/services/local_storage/preferences.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';

class Translation {
  Map<String, dynamic> translationData;

  int scoreID;
  int? updated;

  String word;
  String translation;

  bool favorite;

  Map<String, dynamic> score;

  Translation({
    required this.translationData,
    required this.scoreID,
    required this.word,
    required this.translation,
    required this.favorite,
    required this.score,
    this.updated
  });

  factory Translation.fromJson(Map<String, dynamic> translationData) {
    Translation translationFromJson = switch (translationData) {
      {
        "score_id": int scoreID,
        "word": String word,
        "translation": String translation,
        "favorite": bool favorite,
        "score": Map score,
      } =>
        Translation(
          translationData: translationData,
          scoreID: scoreID,
          word: word,
          translation: translation,
          favorite: favorite,
          score: score as Map<String, dynamic>,
        ),
      _ => throw const FormatException("Failed to load Translation."),
    };
    
    if (translationData.containsKey("updated")) {
      translationFromJson.updated = translationData["updated"];
    }

    return translationFromJson;
  }

  Map<String, dynamic> toMap() {
    return {
      "score_id": scoreID,
      "word": word,
      "translation": translation,
      "favorite": favorite,
      "score": score,
      "updated": updated
    };
  }

  Map<String, dynamic> toMapSync() {
    return {
      "score_id": scoreID,
      "favorite": favorite,
      "score": score,
      "updated": updated
    };
  }

  void setFavorite(bool state) {
    favorite = state;
    updated = DateTime.now().millisecondsSinceEpoch;
    
    APIQuizzes.setFavorite(QuizHelper.quiz!.id, scoreID, state);
  }

  void toggleFavorite() {
    favorite = !favorite;
    updated = DateTime.now().millisecondsSinceEpoch;

    APIQuizzes.setFavorite(QuizHelper.quiz!.id, scoreID, favorite);
  }

  String answer() {
    if (Preferences.answerLanguage == 0) {
      return word;
    }
    return translation;
  }

  void setScore(String uuid, String mode, int newScore) {
    score[mode] = newScore;
    updated = DateTime.now().millisecondsSinceEpoch;

    APIQuizzes.setScore(uuid, scoreID, mode, score[mode]!);
  }
}
