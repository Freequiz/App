import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_create_quiz/error_pop_up.dart';
import 'package:freequiz/1_edit/edit_create_quiz/progress_pop_up.dart';
import 'package:freequiz/1_edit/quiz_form.dart';
import 'package:freequiz/_views/edit/edit_view.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/manage.dart';

class EditQuiz extends StatefulWidget {
  final Function refresh;
  final String uuid;
  final bool owner;
  const EditQuiz({super.key, required this.refresh, required this.uuid, this.owner = true});

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
        backgroundColor: DeviceInfo.darkMode ? grayFreequiz : blueFreequiz,
        leading: TextButton(
          onPressed: () {
            if (changed()) {
              quiz.save();
            }
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
            quiz.save();
          }
        },
        child: Padding(
          padding: DeviceInfo.mobileLayout
              ? const EdgeInsets.all(10.0)
              : EdgeInsets.symmetric(horizontal: DeviceInfo().width() / 5.5, vertical: 10.0),
          child: FutureBuilder<Map>(
            future: ManageQuiz.load(widget.uuid, false),
            builder: (context, data) {
              if (data.hasData) {
                if (data.data!['success']) {
                  debugPrint(data.data!['quiz_data'].toString());
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
                      quiz.wordPairs[i].id = quizData['data'][i]['id'];
                    }
                  }
                }
                return EditView(quiz: quiz);
              }
              return Center(child: CircularProgressIndicator(color: DeviceInfo.darkMode ? Colors.white : grayFreequiz));
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
