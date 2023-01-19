import 'package:freequiz/others/load_quiz.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';

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
