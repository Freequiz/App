import 'package:freequiz/app.dart';
import 'package:freequiz/router/load_quiz.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const App(),
      routes: [
        GoRoute(
          path: 'quiz/:quizUuid',
          builder: (context, state) => state.params['quizUuid'] != null
              ? LoadQuiz(uuid: state.params['quizUuid']!)
              : const App(),
        ),
      ],
    ),
  ],
);
