import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_create_quiz/answer_textfield.dart';
import 'package:freequiz/1_edit/edit_create_quiz/error_pop_up.dart';
import 'package:freequiz/1_edit/edit_create_quiz/progress_pop_up.dart';
import 'package:freequiz/1_edit/quiz_form.dart';
import 'package:freequiz/local_storage/quizzes.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/languages.dart';
import 'package:freequiz/others/style.dart';
import '../edit_create_quiz/basic_textfield.dart';

class EditDraft extends StatefulWidget {
  final Function refresh;
  const EditDraft({super.key, required this.refresh});

  @override
  State<EditDraft> createState() => _EditDraftState();
}

class _EditDraftState extends State<EditDraft> {
  bool firstTime = true;

  QuizForm quiz = QuizForm();

  @override
  void initState() {
    final quizData = QuizHelper.draft;
    quiz.title.input.text = quizData['title'];
    quiz.description.input.text = quizData['description'];
    quiz.definitionLanguage = int.parse(quizData['from']);
    quiz.answerLanguage = int.parse(quizData['to']);
    firstTime = false;
    for (var i = 0; i < quizData['translations_attributes'].length; i++) {
      if (i >= quiz.wordPairs.length) {
        quiz.addWordPair();
      }
      quiz.wordPairs[i].definition.input.text = quizData['translations_attributes']["$i"]['word'];
      quiz.wordPairs[i].answer.input.text = quizData['translations_attributes']["$i"]['translation'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hintColor = DeviceInfo.darkMode
        ? Colors.white
        : const Color.fromARGB(255, 40, 40, 40);
    return Scaffold(
      appBar: AppBar(
        title: const Text('draft').tr(),
        backgroundColor: DeviceInfo.darkMode ? grayFreequiz : blueFreequiz,
        leading: TextButton(
          onPressed: () {
            save();
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
          save();
        },
        child: Padding(
          padding: DeviceInfo.mobileLayout
              ? const EdgeInsets.all(10.0)
              : EdgeInsets.symmetric(
                  horizontal: DeviceInfo().width() / 5.5, vertical: 10.0),
          child: ListView(
            children: [
              SizedBox(
                height: DeviceInfo().height() / 60,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(DeviceInfo().height() / 100),
                  color: DeviceInfo.darkMode
                      ? const Color.fromARGB(255, 55, 55, 55)
                      : blueFreequiz,
                ),
                child: Padding(
                  padding: EdgeInsets.all(DeviceInfo().height() / 100),
                  child: Column(
                    children: [
                      BasicTextField(
                        textFieldData: quiz.title,
                        hintError: context.tr('title error'),
                        colorBorder: (DeviceInfo.darkMode ? yellowFreequiz : grayFreequiz),
                        widthBorder: 3.0,
                        save: save,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BasicTextField(
                        textFieldData: quiz.description,
                        hintError: context.tr('description error'),
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        save: save,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownButton(
                            value: quiz.definitionLanguage,
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: grayFreequiz,
                            ),
                            underline: Container(
                              height: 2,
                              color: grayFreequiz,
                            ),
                            dropdownColor: DeviceInfo.darkMode
                                ? const Color.fromARGB(255, 40, 40, 40)
                                : const Color.fromARGB(255, 229, 242, 250),
                            items: Languages.languages,
                            onChanged: (value) {
                              setState(() {
                                quiz.definitionLanguage = value!;
                              });
                            },
                            style: TextStyle(color: hintColor),
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: grayFreequiz,
                          ),
                          DropdownButton(
                            value: quiz.answerLanguage,
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: grayFreequiz,
                            ),
                            underline: Container(
                              height: 2,
                              color: grayFreequiz,
                            ),
                            dropdownColor: DeviceInfo.darkMode
                                ? const Color.fromARGB(255, 40, 40, 40)
                                : const Color.fromARGB(255, 229, 242, 250),
                            items: Languages.languages,
                            onChanged: (value) {
                              setState(() {
                                quiz.answerLanguage = value!;
                              });
                            },
                            style: TextStyle(color: hintColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: DeviceInfo().height() / 40,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quiz.wordPairs.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: DeviceInfo().height() / 60,
                  );
                },
                itemBuilder: (BuildContext context, int i) {
                  WordPair wordPair = quiz.wordPairs[i];
                  return Dismissible(
                    key: Key(wordPair.definition.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        quiz.wordPairs.removeAt(i);
                      });
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(DeviceInfo().height() / 100),
                        color: Colors.red,
                      ),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(DeviceInfo().height() / 100),
                        color: DeviceInfo.darkMode
                            ? const Color.fromARGB(255, 55, 55, 55)
                            : blueFreequiz,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(DeviceInfo().height() / 100),
                        child: Column(
                          children: [
                            BasicTextField(
                              textFieldData: wordPair.definition,
                              hintError: context.tr('definition errror'),
                              save: save,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AnswerTextField(
                              textFieldData: wordPair.answer,
                              onSubmitted: onSubmitted,
                              i: i,
                              save: save,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: DeviceInfo().height() / 40,
              ),
              Align(
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: grayFreequiz, foregroundColor: Colors.white),
                  onPressed: () {
                    setState(() {
                      quiz.addWordPair();
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSubmitted(int i) {
    setState(() {
      if (quiz.wordPairs[i].definition.input.text != "" &&
          quiz.wordPairs[i].answer.input.text != "") {
        if (i + 2 >= quiz.wordPairs.length) {
          quiz.addWordPair();
        }
        FocusScope.of(context).nextFocus();
      }
    });
  }

  onPressed() async {
    quiz.checkForErrors();

    if (quiz.error) {
      setState(() {});
    }
    
    if (quiz.counter < 3) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const ErrorPopUp());
    }

    if (!quiz.error) {
      final map = quiz.createMap();
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

  save() {
    final map = quiz.createMap();
    LocalStorage.saveDraft(map);
    QuizHelper.draft = map;
  }
}
