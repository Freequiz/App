import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_create_quiz/answer_textfield.dart';
import 'package:freequiz/1_edit/edit_create_quiz/error_pop_up.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/api/convert_json.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/languages.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/textfield_data.dart';

import '../edit_create_quiz/basic_textfield.dart';

class EditDraft extends StatefulWidget {
  final Function refresh;
  const EditDraft({super.key, required this.refresh});

  @override
  State<EditDraft> createState() => _EditDraftState();
}

class _EditDraftState extends State<EditDraft> {
  int wordCount = 3;
  int definitionLanguage = 1;
  int answerLanguage = 3;
  bool firstTime = true;
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
  void initState() {
    final quizData = Quiz.draft;
    title.input.text = quizData['title'];
    description.input.text = quizData['description'];
    definitionLanguage = int.parse(quizData['from']);
    answerLanguage = int.parse(quizData['to']);
    firstTime = false;
    for (var i = 0; i < quizData['data'].length; i++) {
      if (i >= definitions.length) {
        wordCount++;
        definitions.add(TextFieldData(hint: "Description"));
        answers.add(TextFieldData(hint: "Answer"));
      }
      definitions[i].input.text = quizData['data'][i]['w'];
      answers[i].input.text = quizData['data'][i]['t'];
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
        title: Text(language["Draft"]),
        backgroundColor: DeviceInfo.darkMode ? color1 : color4,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
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
            child: Text(
              language["Done"],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: DeviceInfo.height / 60,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DeviceInfo.height / 100),
              color: DeviceInfo.darkMode
                  ? const Color.fromARGB(255, 55, 55, 55)
                  : color4,
            ),
            child: Padding(
              padding: EdgeInsets.all(DeviceInfo.height / 100),
              child: Column(
                children: [
                  BasicTextField(
                    textFieldData: title,
                    hintError: language["Title can't be blank"],
                    colorBorder: (DeviceInfo.darkMode ? color3 : color1),
                    widthBorder: 3.0,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  BasicTextField(
                    textFieldData: description,
                    hintError: language["Description can't be blank"],
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
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
            height: DeviceInfo.height / 40,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: wordCount,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: DeviceInfo.height / 60,
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
                        BorderRadius.circular(DeviceInfo.height / 100),
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
                        BorderRadius.circular(DeviceInfo.height / 100),
                    color: DeviceInfo.darkMode
                        ? const Color.fromARGB(255, 55, 55, 55)
                        : color4,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(DeviceInfo.height / 100),
                    child: Column(
                      children: [
                        BasicTextField(
                          textFieldData: definitions[i],
                          hintError: language["Definition can't be blank"],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        AnswerTextField(
                          textFieldData: answers[i],
                          onSubmitted: onSubmitted,
                          i: i,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: DeviceInfo.height / 40,
          ),
          Align(
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: color1, foregroundColor: Colors.white),
              onPressed: () {
                setState(() {
                  wordCount++;
                  definitions.add(TextFieldData(hint: "Description"));
                  answers.add(TextFieldData(hint: "Answer"));
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
    );
  }

  onSubmitted(int i) {
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
    if (title.input.text.replaceAll(' ', '') == "") {
      setState(() {
        title.error = true;
        error = true;
        title.input.clear();
      });
    }
    if (description.input.text.replaceAll(' ', '') == "") {
      setState(() {
        description.error = true;
        error = true;
        description.input.clear();
      });
    }
    if (!error) {
      await APIQuizzes().httpPutQuiz(
        mapQuiz(
            title: title.input.text,
            description: description.input.text,
            visibility: "public",
            from: definitionLanguage.toString(),
            to: answerLanguage.toString(),
            definitions: definitions,
            answers: answers),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      widget.refresh;
    }
  }
}
