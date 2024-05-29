import 'package:freequiz/app.dart';
import 'package:freequiz/loading/load_quiz.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const App(),
      routes: [
        GoRoute(
          path: 'quiz/:quizUuid',
          builder: (context, state) => state.pathParameters['quizUuid'] != null
              ? LoadQuiz(uuid: state.pathParameters['quizUuid']!)
              : const App(),
        ),
      ],
    ),
  ],
);
