import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_create_quiz/answer_textfield.dart';
import 'package:freequiz/1_edit/edit_create_quiz/basic_textfield.dart';
import 'package:freequiz/1_edit/edit_create_quiz/error_pop_up.dart';
import 'package:freequiz/1_edit/edit_create_quiz/progress_pop_up.dart';
import 'package:freequiz/1_edit/quiz.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/languages.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/textfield_data.dart';

class CreateQuiz extends StatefulWidget {
  final Function refresh;
  const CreateQuiz({super.key, required this.refresh});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  int wordCount = 3;

  QuizForm quiz = QuizForm();

  @override
  Widget build(BuildContext context) {
    final hintColor = DeviceInfo.darkMode
        ? Colors.white
        : const Color.fromARGB(255, 40, 40, 40);
    return Scaffold(
      appBar: AppBar(
        title: Text(language["Create Quiz"]),
        backgroundColor: DeviceInfo.darkMode ? color1 : color4,
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
            onPressed: () => onPressed(),
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
                      : color4,
                ),
                child: Padding(
                  padding: EdgeInsets.all(DeviceInfo().height() / 100),
                  child: Column(
                    children: [
                      BasicTextField(
                        textFieldData: quiz.title,
                        hintError: language["Title at least 3 characters"],
                        colorBorder: (DeviceInfo.darkMode ? color3 : color1),
                        widthBorder: 3.0,
                        save: save,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BasicTextField(
                        textFieldData: quiz.description,
                        hintError: language["Description can't be blank"] +
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
                              color: color1,
                            ),
                            underline: Container(
                              height: 2,
                              color: color1,
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
                            color: color1,
                          ),
                          DropdownButton(
                            value: quiz.answerLanguage,
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: color1,
                            ),
                            underline: Container(
                              height: 2,
                              color: color1,
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
                            : color4,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(DeviceInfo().height() / 100),
                        child: Column(
                          children: [
                            BasicTextField(
                              textFieldData: quiz.definitions[i],
                              hintError: language["Definition can't be blank"],
                              save: save,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AnswerTextField(
                              textFieldData: quiz.answers[i],
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
                      backgroundColor: color1, foregroundColor: Colors.white),
                  onPressed: () {
                    setState(() {
                      wordCount++;
                      quiz.definitions
                          .add(TextFieldData(hint: language["Definition"]));
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
          ),
        ),
      ),
    );
  }

  onPressed() async {
    bool error = false;
    int counter = 0;

    for (var i = 0; i < quiz.definitions.length; i++) {
      if (quiz.emptyDefinition(i)) {
        setState(() {
          quiz.definitions[i].error = true;
          quiz.definitions[i].input.clear();
          error = true;
        });
      } else if (quiz.emptyAnswer(i)) {
        setState(() {
          quiz.answers[i].error = true;
          quiz.answers[i].input.clear();
          error = true;
        });
      } else {
        counter++;
      }
    }
    
    if (counter < 3) {
      error = true;
      showDialog(
          context: context,
          builder: (BuildContext context) => const ErrorPopUp());
    }
    if (quiz.title.input.text.replaceAll(' ', '').length < 3) {
      setState(() {
        quiz.title.error = true;
        error = true;
        quiz.title.input.clear();
      });
    }
    if (quiz.description.input.text.replaceAll(' ', '').length < 5) {
      setState(() {
        quiz.description.error = true;
        error = true;
        quiz.description.input.clear();
      });
    }
    if (!error) {
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

  onSubmitted(i) {
    setState(() {
      if (quiz.definitions[i].input.text != "" &&
          quiz.answers[i].input.text != "") {
        if (i + 2 >= wordCount) {
          wordCount++;
          quiz.definitions.add(TextFieldData(hint: language["Definition"]));
          quiz.answers.add(TextFieldData(hint: language["Answer"]));
        }
        FocusScope.of(context).nextFocus();
      }
    });
  }

  changed() {
    if (quiz.title.input.text.isNotEmpty) {
      return true;
    }
    if (quiz.description.input.text.isNotEmpty) {
      return true;
    }
    for (var i = 0; i < quiz.definitions.length; i++) {
      if (quiz.definitions[i].input.text.isNotEmpty) {
        return true;
      }
      if (quiz.answers[i].input.text.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  save() {
    final map = quiz.createMap();

    Quiz().saveDraft(map);
    Quiz.draft = map;
  }
}
