import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/pop_ups/error.dart';
import 'package:freequiz/_views/edit/pop_ups/progress.dart';
import 'package:freequiz/_views/edit/edit_create_quiz/edit_view.dart';
import 'package:freequiz/controllers/edit/edit.dart';
import 'package:freequiz/controllers/edit/quiz_form.dart';
import 'package:freequiz/services/api/quizzes.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class CreateQuiz extends StatefulWidget {
  final Function refresh;
  const CreateQuiz({super.key, required this.refresh});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  QuizForm quiz = EditController.quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('create quiz').tr(),
        leading: TextButton(
          onPressed: () {
            if (quiz.changed()) quiz.save(mode: 'create');
            Navigator.of(context).pop();
            widget.refresh();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () => onPressed(),
            child: Text(
              context.tr('done'),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (quiz.changed()) quiz.save(mode: 'create');
        },
        child: Padding(
          padding: context.mobileLayout
              ? const EdgeInsets.all(10.0)
              : EdgeInsets.symmetric(horizontal: context.screenWidth / 5.5, vertical: 10.0),
          child: EditView(quiz: quiz, mode: 'create', scanning: true),
        ),
      ),
    );
  }

  void onPressed() async {
    quiz.checkForErrors();

    if (quiz.error) {
      setState(() {});
    }

    if (quiz.counter < 3) {
      showDialog(context: context, builder: (BuildContext context) => const ErrorPopUp());
    }

    if (!quiz.error) {
      final map = quiz.createMap();
      final response = APIQuizzes.createQuiz(map);

      showDialog(
        context: context,
        builder: (context) => ProgressPopUp(
          title: 'Create Quiz',
          response: response,
          refresh: (_) => widget.refresh(),
        ),
      );
    }
  }
}
