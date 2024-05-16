import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_create_quiz/answer_textfield.dart';
import 'package:freequiz/1_edit/edit_create_quiz/basic_textfield.dart';
import 'package:freequiz/1_edit/edit_create_quiz/error_pop_up.dart';
import 'package:freequiz/1_edit/edit_create_quiz/progress_pop_up.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/api/convert_json.dart';
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
  int definitionLanguage = 1;
  int answerLanguage = 3;
  List<TextFieldData> definitions = [
    TextFieldData(hint: language["Definition"]),
    TextFieldData(hint: language["Definition"]),
    TextFieldData(hint: language["Definition"])
  ];
  List<TextFieldData> answers = [
    TextFieldData(hint: language["Answer"]),
    TextFieldData(hint: language["Answer"]),
    TextFieldData(hint: language["Answer"])
  ];
  final title = TextFieldData(hint: language["Title"]);
  final description = TextFieldData(hint: language["Description"]);
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
          child: ListView(
            children: [
              SizedBox(
                height: DeviceInfo().height() / 60,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
                  color: DeviceInfo.darkMode
                      ? const Color.fromARGB(255, 55, 55, 55)
                      : color4,
                ),
                child: Padding(
                  padding: EdgeInsets.all(DeviceInfo().height() / 100),
                  child: Column(
                    children: [
                      BasicTextField(
                        textFieldData: title,
                        hintError: language["Title at least 3 characters"],
                        colorBorder: (DeviceInfo.darkMode ? color3 : color1),
                        widthBorder: 3.0,
                        save: save,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BasicTextField(
                        textFieldData: description,
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
                            value: definitionLanguage,
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
                                definitionLanguage = value!;
                              });
                            },
                            style: TextStyle(color: hintColor),
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: color1,
                          ),
                          DropdownButton(
                            value: answerLanguage,
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
                                answerLanguage = value!;
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
                    key: Key(definitions[i].id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        definitions.removeAt(i);
                        answers.removeAt(i);
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
                              textFieldData: definitions[i],
                              hintError: language["Definition can't be blank"],
                              save: save,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AnswerTextField(
                              textFieldData: answers[i],
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
                      definitions.add(TextFieldData(hint: language["Definition"]));
                      answers.add(TextFieldData(hint: language["Answer"]));
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
    for (var i = 0; i < definitions.length; i++) {
      if (definitions[i].input.text.replaceAll(' ', '') == "") {
        if (answers[i].input.text.replaceAll(' ', '') != "") {
          setState(() {
            definitions[i].error = true;
            definitions[i].input.clear();
            error = true;
          });
        }
      } else if (answers[i].input.text.replaceAll(' ', '') == "") {
        if (definitions[i].input.text.replaceAll(' ', '') != "") {
          setState(() {
            answers[i].error = true;
            answers[i].input.clear();
            error = true;
          });
        }
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
    if (title.input.text.replaceAll(' ', '').length < 3) {
      setState(() {
        title.error = true;
        error = true;
        title.input.clear();
      });
    }
    if (description.input.text.replaceAll(' ', '').length < 5) {
      setState(() {
        description.error = true;
        error = true;
        description.input.clear();
      });
    }
    if (!error) {
      final map = mapQuiz(
          title: title.input.text,
          description: description.input.text,
          visibility: "public",
          from: definitionLanguage.toString(),
          to: answerLanguage.toString(),
          definitions: definitions,
          answers: answers);
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
      if (definitions[i].input.text != "" && answers[i].input.text != "") {
        if (i + 2 >= wordCount) {
          wordCount++;
          definitions.add(TextFieldData(hint: language["Definition"]));
          answers.add(TextFieldData(hint: language["Answer"]));
        }
        FocusScope.of(context).nextFocus();
      }
    });
  }

  changed() {
    if (title.input.text.isNotEmpty) {
      return true;
    }
    if (description.input.text.isNotEmpty) {
      return true;
    }
    for (var i = 0; i < definitions.length; i++) {
      if (definitions[i].input.text.isNotEmpty) {
        return true;
      }
      if (answers[i].input.text.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  save() {
    final map = mapQuiz(
      title: title.input.text,
      description: description.input.text,
      visibility: "public",
      from: definitionLanguage.toString(),
      to: answerLanguage.toString(),
      definitions: definitions,
      answers: answers,
      noBlank: false,
    );
    Quiz().saveDraft(map);
    Quiz.draft = map;
  }
}
