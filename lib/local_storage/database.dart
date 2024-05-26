import 'dart:convert';
import 'package:freequiz/models/quiz.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class QuizDatabase {
  static late Future<Database> database;

  static late List<Map> loadedQuizzes;

  static Future<void> open() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'quizzes_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE quizzes(id TEXT PRIMARY KEY, title TEXT, description TEXT, visibility TEXT, created_by TEXT, owner TEXT, favorite TEXT, from_language TEXT, to_language TEXT, data TEXT, time INTEGER)',
        );
      },
      version: 1,
    );

    manageQuizzes();
  }

  static Future<void> insertQuiz(Quiz quiz) async {
    final db = await database;

    await db.insert(
      'quizzes',
      quiz.toMapDatabase(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map>> loadQuizzes() async {
    final db = await database;

    final List<Map<String, Object?>> quizzesMap = await db.query(
      'quizzes',
      orderBy: 'time DESC',
      limit: 20,
    );

    List<Map> decodedMaps = [];

    for (Map<String, Object?> quizMap in quizzesMap) {
      Map<String, Object?> map = Map<String, Object?>.from(quizMap);

      map['data'] = json.decode(map['data'] as String);
      map['from'] = json.decode(map['from_language'] as String);
      map['to'] = json.decode(map['to_language'] as String);
      map['owner'] = map['owner'] == "true";
      map['favorite'] = map['favorite'] == "true";

      decodedMaps.add(map);
    }

    loadedQuizzes = decodedMaps;
    return decodedMaps;
  }

  static Future<Map> loadQuiz(String id) async {
    final db = await database;

    final List<Map<String, Object?>> response = await db.query(
      'quizzes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (response.isEmpty) {
      return {};
    }

    Map<String, Object> map = Map<String, Object>.from(response.first);

    map['data'] = json.decode(map['data'] as String);
    map['from'] = json.decode(map['from_language'] as String);
    map['to'] = json.decode(map['to_language'] as String);
    map['owner'] = map['owner'] == "true";
    map['favorite'] = map['favorite'] == "true";

    return {
      "success": true,
      "quiz_data": map,
    };
  }

  static Future<void> updateQuiz(Quiz quiz) async {
    final db = await database;

    await db.update(
      'quizzes',
      quiz.toMapDatabase(),
      where: 'id = ?',
      whereArgs: [quiz.id],
    );
  }

  static Future<void> deleteQuiz(String id) async {
    final db = await database;

    await db.delete(
      'quizzes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> manageQuizzes() async {
    final db = await database;

    await db.delete('quizzes',
        where: 'time < ?',
        whereArgs: [DateTime.now().millisecondsSinceEpoch - 2629746000] //delete quizzes older than a month
        );
  }
}
