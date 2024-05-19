import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/quiz.dart';

class Translation {
  Map<String, dynamic> translationData;

  int scoreID;

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
  });

  factory Translation.fromJson(Map<String, dynamic> translationData) {
    return switch (translationData) {
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
  }

  Map<String, dynamic> toMap() {
    return {
      "score_id": scoreID,
      "word": word,
      "translation": translation,
      "favorite": favorite,
      "score": score,
    };
  }

  setFavorite(bool state) {
    favorite = state;
    APIQuizzes.setFavorites(QuizHelper.quiz!.id, scoreID, state);
  }

  toggleFavorite() {
    favorite = !favorite;
    APIQuizzes.setFavorites(QuizHelper.quiz!.id, scoreID, favorite);
  }
}
