import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/edit_create_quiz/error_pop_up.dart';
import 'package:freequiz/_views/edit/edit_create_quiz/progress_pop_up.dart';
import 'package:freequiz/_views/subviews/edit/edit_view.dart';
import 'package:freequiz/controllers/edit/quiz_form.dart';
import 'package:freequiz/services/api/quizzes.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:freequiz/controllers/quiz/manage.dart';

class EditQuiz extends StatefulWidget {
  final Function refresh;
  final String uuid;
  final bool owner;
  final bool openQuiz;
  const EditQuiz({super.key, required this.refresh, required this.uuid, this.openQuiz = false, this.owner = true});

  @override
  State<EditQuiz> createState() => _EditQuizState();
}

class _EditQuizState extends State<EditQuiz> {
  bool firstTime = true;

  QuizForm quiz = QuizForm();

  Map quizData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.owner ? const Text('edit quiz').tr() : const Text('create quiz').tr(),
        leading: TextButton(
          onPressed: () {
            if (changed()) {
              quiz.save(mode: widget.owner ? 'edit' : 'create', id: widget.uuid);
            }
            Navigator.of(context).pop();
            widget.refresh(null);
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
          if (changed()) {
            quiz.save(mode: widget.owner ? 'edit' : 'create', id: widget.uuid);
          }
        },
        child: Padding(
          padding: context.mobileLayout
              ? const EdgeInsets.all(10.0)
              : EdgeInsets.symmetric(horizontal: context.screenWidth / 5.5, vertical: 10.0),
          child: FutureBuilder<Map>(
            future: ManageQuiz.load(widget.uuid, false),
            builder: (context, data) {
              if (data.hasData) {
                if (data.data!['success']) {
                  quizData = data.data!['quiz_data'];
                  if (firstTime) {
                    quiz.title.input.text = quizData['title'];
                    quiz.description.input.text = quizData['description'];
                    quiz.definitionLanguage = int.parse(quizData['from']['id']);
                    quiz.answerLanguage = int.parse(quizData['to']['id']);
                    firstTime = false;

                    for (var i = 0; i < quizData['data'].length; i++) {
                      if (i >= quiz.wordPairs.length) {
                        quiz.addWordPair();
                      }
                      quiz.wordPairs[i].definition.input.text = quizData['data'][i]['word'];
                      quiz.wordPairs[i].answer.input.text = quizData['data'][i]['translation'];
                      quiz.wordPairs[i].id = quizData['data'][i]['id'].toString();
                    }
                  }
                }
                return EditView(quiz: quiz, mode: widget.owner ? 'edit' : 'create');
              }
              return Center(child: CircularProgressIndicator(color: context.darkMode ? Colors.white : grayFreequiz));
            },
          ),
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
      if (widget.owner) {
        final response = APIQuizzes.updateQuiz(map, widget.uuid);
        showDialog(
          context: context,
          builder: (context) => ProgressPopUp(
            title: 'Edit Quiz',
            response: response,
            refresh: (_) {
              widget.refresh(widget.uuid);
            },
          ),
        );
      } else {
        for (Map translationAttribute in map['translations_attributes'].values) {
          translationAttribute.remove('id');
        }
        final response = APIQuizzes.createQuiz(map);
        showDialog(
          context: context,
          builder: (context) => ProgressPopUp(
            title: 'Create Quiz',
            response: response,
            refresh: (id) {
              widget.refresh(id);
            },
          ),
        );
      }
    }
  }

  bool changed() {
    if (quiz.title.input.text != quizData['title']) {
      return true;
    }
    if (quiz.description.input.text != quizData['description']) {
      return true;
    }
    if (quiz.definitionLanguage != int.parse(quizData['from']['id'])) {
      return true;
    }
    if (quiz.answerLanguage != int.parse(quizData['to']['id'])) {
      return true;
    }
    if (quiz.wordPairs.length != quizData['data'].length) {
      return true;
    }
    for (var i = 0; i < quizData['data'].length; i++) {
      if (quiz.wordPairs[i].definition.input.text != quizData['data'][i]['word']) {
        return true;
      }
      if (quiz.wordPairs[i].answer.input.text != quizData['data'][i]['translation']) {
        return true;
      }
    }
    return false;
  }
}
