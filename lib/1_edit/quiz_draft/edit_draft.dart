import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/1_edit/edit_create_quiz/error_pop_up.dart';
import 'package:freequiz/1_edit/edit_create_quiz/progress_pop_up.dart';
import 'package:freequiz/1_edit/quiz_form.dart';
import 'package:freequiz/_views/edit/edit_view.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class EditDraft extends StatefulWidget {
  final Function refresh;
  const EditDraft({super.key, required this.refresh});

  @override
  State<EditDraft> createState() => _EditDraftState();
}

class _EditDraftState extends State<EditDraft> {
  bool firstTime = true;
  String mode = "";
  String? id;

  QuizForm quiz = QuizForm();

  @override
  void initState() {
    final quizData = QuizHelper.draft;
    quiz.title.input.text = quizData['title'];
    quiz.description.input.text = quizData['description'];
    quiz.definitionLanguage = int.parse(quizData['from']);
    quiz.answerLanguage = int.parse(quizData['to']);

    firstTime = false;
    mode = quizData['mode'];
    id = quizData['id'];

    for (var i = 0; i < quizData['translations_attributes'].length; i++) {
      if (i >= quiz.wordPairs.length) {
        quiz.addWordPair();
      }
      quiz.wordPairs[i].definition.input.text = quizData['translations_attributes']["$i"]['word'];
      quiz.wordPairs[i].answer.input.text = quizData['translations_attributes']["$i"]['translation'];
      quiz.wordPairs[i].id = quizData['translations_attributes']["$i"]['id'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('draft').tr(),
        backgroundColor: context.darkMode ? grayFreequiz : blueFreequiz,
        leading: TextButton(
          onPressed: () {
            quiz.save(mode: mode, id: id);
            Navigator.of(context).pop();
            widget.refresh;
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
            onPressed: () {
              onPressed();
            },
            child: const Text('done').tr(),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          quiz.save(mode: mode, id: id);
        },
        child: Padding(
          padding: context.mobileLayout
              ? const EdgeInsets.all(10.0)
              : EdgeInsets.symmetric(horizontal: context.screenWidth / 5.5, vertical: 10.0),
          child: EditView(quiz: quiz),
        ),
      ),
    );
  }

  onPressed() async {
    quiz.checkForErrors();

    if (quiz.error) {
      setState(() {});
    }

    if (quiz.counter < 3) {
      showDialog(context: context, builder: (BuildContext context) => const ErrorPopUp());
    }

    if (!quiz.error) {
      final map = quiz.createMap();

      if (mode == 'edit' && id != null) {
        final response = APIQuizzes.updateQuiz(map, id!);
        showDialog(
          context: context,
          builder: (context) => ProgressPopUp(
            title: 'Edit Quiz',
            response: response,
            refresh: widget.refresh,
          ),
        );
      } else {
        final response = APIQuizzes.createQuiz(map);
        showDialog(
          context: context,
          builder: (context) => ProgressPopUp(
            title: 'Create Quiz',
            response: response,
            refresh: widget.refresh,
          ),
        );
      }
    }
  }
}
