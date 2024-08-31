import 'package:flutter/material.dart';
import 'package:freequiz/app.dart';
import 'package:freequiz/loading/load_quiz.dart';
import 'package:freequiz/loading/load_user.dart';

Route<dynamic>? appRouter(RouteSettings settings) {
  Widget routeWidget = const App();
  bool fullscreenDialog = false;

  final routeName = settings.name;
  debugPrint('Navigating to: $routeName');

  if (routeName != null) {
    if (routeName.startsWith('/quiz/')) {
      final uuid = routeName.substring('/quiz/'.length);
      if (uuid.isNotEmpty) {
        routeWidget = LoadQuiz(uuid: uuid);
        fullscreenDialog = true;
      }
    } else if (routeName.startsWith('/user/')) {
      final user = routeName.substring('/user/'.length);
      if (user.isNotEmpty) {
        routeWidget = LoadUser(user: user);
        fullscreenDialog = true;
      }
    }
  }

  return MaterialPageRoute(
    builder: (context) => routeWidget,
    settings: settings,
    fullscreenDialog: fullscreenDialog,
  );
}
