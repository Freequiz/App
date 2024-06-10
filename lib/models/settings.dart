import 'package:freequiz/api/users.dart';

class Settings {
  Map settingsData;

  int multi;
  int cards;
  int write;
  int smart = 3;

  Settings({required this.settingsData, required this.multi, required this.cards, required this.write});

  factory Settings.fromJson(Map settingsData) {
    return switch (settingsData) {
      {
        "multi_amount": int multi,
        "cards_amount": int cards,
        "write_amount": int write,
      } =>
        Settings(settingsData: settingsData, multi: multi, cards: cards, write: write),
      _ => throw const FormatException("Failed to load User."),
    };
  }

  Map toMap() {
    return {
      "multi_amount": multi,
      "cards_amount": cards,
      "write_amount": write
    };
  }

  int maxScore(String mode) {
    switch (mode) {
      case "multi":
        return multi;
      case "cards":
        return cards;
      case "write":
        return write;
      case "smart":
        return smart;
      default:
        throw Exception("Mode not found");
    }
  }

  setScore(String mode, int n) {
    switch (mode) {
      case "multi":
        multi = n;
        break;
      case "cards":
        cards = n;
        break;
      case "write":
        write = n;
        break;
      default:
        throw Exception("Mode not found");
    }

    APIUsers.updateSettings({"${mode}_amount": n});
  }
}
