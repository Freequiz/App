import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_create_quiz/answer_textfield.dart';
import 'package:freequiz/1_edit/edit_create_quiz/basic_textfield.dart';
import 'package:freequiz/1_edit/edit_create_quiz/error_pop_up.dart';
import 'package:freequiz/1_edit/edit_create_quiz/progress_pop_up.dart';
import 'package:freequiz/1_edit/quiz_form.dart';
import 'package:freequiz/local_storage/quizzes.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/languages.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/textfield_data.dart';
import 'package:freequiz/quiz/manage.dart';

class EditQuiz extends StatefulWidget {
  final Function refresh;
  final String uuid;
  final bool owner;
  const EditQuiz(
      {super.key,
      required this.refresh,
      required this.uuid,
      this.owner = true});

  @override
  State<EditQuiz> createState() => _EditQuizState();
}

class _EditQuizState extends State<EditQuiz> {
  int wordCount = 3;
  bool firstTime = true;

  QuizForm quiz = QuizForm();

  Map quizData = {};

  @override
  Widget build(BuildContext context) {
    final hintColor = DeviceInfo.darkMode
        ? Colors.white
        : const Color.fromARGB(255, 40, 40, 40);
    return Scaffold(
      appBar: AppBar(
        title: widget.owner
            ? Text(language["Edit Quiz"])
            : Text(language['Create Quiz']),
        backgroundColor: DeviceInfo.darkMode ? grayFreequiz : blueFreequiz,
        leading: TextButton(
          onPressed: () {
            if (changed()) {
              save();
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
              language["Done"],
            ),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (changed()) {
            save();
          }
        },
        child: Padding(
          padding: DeviceInfo.mobileLayout
              ? const EdgeInsets.all(10.0)
              : EdgeInsets.symmetric(
                  horizontal: DeviceInfo().width() / 5.5, vertical: 10.0),
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
                      if (i >= quiz.definitions.length) {
                        wordCount++;
                        quiz.definitions.add(TextFieldData(hint: language["Description"]));
                        quiz.answers.add(TextFieldData(hint: language["Answer"]));
                      }
                      quiz.definitions[i].input.text = quizData['data'][i]['word'];
                      quiz.answers[i].input.text = quizData['data'][i]['translation'];
                    }
                  }
                }
                return ListView(
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
                              hintError:
                                  language["Title at least 3 characters"],
                              colorBorder:
                                  (DeviceInfo.darkMode ? yellowFreequiz : grayFreequiz),
                              widthBorder: 3.0,
                              save: save,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            BasicTextField(
                              textFieldData: quiz.description,
                              hintError: language[
                                      "Description can't be blank"] +
                                  '. ' +
                                  language["Description at least 5 characters"],
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
                                      : const Color.fromARGB(
                                          255, 229, 242, 250),
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
                                      : const Color.fromARGB(
                                          255, 229, 242, 250),
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
                      itemCount: wordCount,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: DeviceInfo().height() / 60,
                        );
                      },
                      itemBuilder: (BuildContext context, int i) {
                        return Dismissible(
                          key: Key(quiz.definitions[i].id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              quiz.definitions.removeAt(i);
                              quiz.answers.removeAt(i);
                              wordCount--;
                            });
                          },
                          background: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  DeviceInfo().height() / 100),
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
                              borderRadius: BorderRadius.circular(
                                  DeviceInfo().height() / 100),
                              color: DeviceInfo.darkMode
                                  ? const Color.fromARGB(255, 55, 55, 55)
                                  : blueFreequiz,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(DeviceInfo().height() / 100),
                              child: Column(
                                children: [
                                  BasicTextField(
                                    textFieldData: quiz.definitions[i],
                                    hintError:
                                        language["Definition can't be blank"],
                                    save: save,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  AnswerTextField(
                                      textFieldData: quiz.answers[i],
                                      onSubmitted: onSubmitted,
                                      i: i,
                                      save: save),
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
                            backgroundColor: grayFreequiz,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          setState(() {
                            wordCount++;
                            quiz.definitions.add(TextFieldData(hint: language["Definition"]));
                            quiz.answers.add(TextFieldData(hint: language["Answer"]));
                          });
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Center(
                    child: CircularProgressIndicator(
                        color: DeviceInfo.darkMode ? Colors.white : grayFreequiz)
              );
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
      showDialog(
          context: context,
          builder: (BuildContext context) => const ErrorPopUp());
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

  onSubmitted(int i) {
    setState(() {
      if (quiz.definitions[i].input.text != "" && quiz.answers[i].input.text != "") {
        if (i + 2 >= wordCount) {
          wordCount++;
          quiz.definitions.add(TextFieldData(hint: language["Definition"]));
          quiz.answers.add(TextFieldData(hint: language["Answer"]));
        }
        FocusScope.of(context).nextFocus();
      }
    });
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
    if (quiz.definitions.length != quizData['data'].length) {
      return true;
    }
    for (var i = 0; i < quizData['data'].length; i++) {
      if (quiz.definitions[i].input.text != quizData['data'][i]['w']) {
        return true;
      }
      if (quiz.answers[i].input.text != quizData['data'][i]['t']) {
        return true;
      }
    }
    return false;
  }

  save() {
    final map = quiz.createMap();
    LocalStorage.saveDraft(map);
    QuizHelper.draft = map;
  }
}
