import 'package:freequiz/models/settings.dart';

class User {
  Map userData;

  String username;
  String email;

  Settings settings;

  User({required this.userData, required this.username, required this.email, required this.settings});

  factory User.fromJson(Map userData) {
    return switch (userData) {
      {
        "username": String username,
        "email": String email,
        "settings": Map settings,
      } =>
        User(userData: userData, username: username, email: email, settings: Settings.fromJson(settings)),
      _ => throw const FormatException("Failed to load User."),
    };
  }

  Map toMap() {
    return {
      "username": username,
      "email": email,
      "settings": settings.toMap()
    };
  }
}
