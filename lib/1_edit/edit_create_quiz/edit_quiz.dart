import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_create_quiz/answer_textfield.dart';
import 'package:freequiz/1_edit/edit_create_quiz/basic_textfield.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/api/convert_json.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/languages.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/textfield_data.dart';

class EditQuiz extends StatefulWidget {
  final Function refresh;
  final String uuid;
  const EditQuiz({super.key, required this.refresh, required this.uuid});

  @override
  State<EditQuiz> createState() => _EditQuizState();
}

class _EditQuizState extends State<EditQuiz> {
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
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final hintColor =
        darkMode ? Colors.white : const Color.fromARGB(255, 40, 40, 40);
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return Scaffold(
      appBar: AppBar(
        title: Text(language["Edit Quiz"]),
        backgroundColor: darkMode ? color1 : color4,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
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
        },
        child: Padding(
          padding: mobileLayout
              ? const EdgeInsets.all(10.0)
              : EdgeInsets.symmetric(horizontal: width / 5.5, vertical: 10.0),
          child: FutureBuilder<Map>(
            future: APIQuizzes().getQuiz(widget.uuid, false),
            builder: (context, data) {
              if (data.hasData) {
                if (data.data!['success']) {
                  final quizData = data.data!['quiz_data'];
                  if (firstTime) {
                  title.input.text = quizData['title'];
                  description.input.text = quizData['description'];
                  definitionLanguage = int.parse(quizData['from']['id']);
                  answerLanguage = int.parse(quizData['to']['id']);
                  firstTime = false;
                  }
                  for (var i = 0; i < quizData['data'].length; i++) {
                    if (i >= definitions.length) {
                      wordCount++;
                      definitions.add(TextFieldData(hint: "Description"));
                      answers.add(TextFieldData(hint: "Answer"));
                    }
                    definitions[i].input.text = quizData['data'][i]['w'];
                    answers[i].input.text = quizData['data'][i]['t'];
                  }
                }
                return ListView(
                  children: [
                    SizedBox(
                      height: height / 60,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height / 100),
                        color: darkMode
                            ? const Color.fromARGB(255, 55, 55, 55)
                            : color4,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(height / 100),
                        child: Column(
                          children: [
                            BasicTextField(
                              textFieldData: title,
                              hintError: language["Title can't be blank"],
                              colorBorder: (darkMode ? color3 : color1),
                              widthBorder: 3.0,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            BasicTextField(
                              textFieldData: description,
                              hintError: language["Description can't be blank"],
                              colorBorder: color1,
                              maxLines: 4,
                              keyboardType: TextInputType.multiline,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DropdownButton(
                                  value: definitionLanguage,
                                  icon: Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: color1,
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: color1,
                                  ),
                                  dropdownColor: darkMode
                                      ? const Color.fromARGB(255, 40, 40, 40)
                                      : const Color.fromARGB(
                                          255, 229, 242, 250),
                                  items: Languages.languages,
                                  onChanged: (value) {
                                    setState(() {
                                      definitionLanguage = value!;
                                    });
                                  },
                                  style: TextStyle(color: hintColor),
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: color1,
                                ),
                                DropdownButton(
                                  value: answerLanguage,
                                  icon: Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: color1,
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: color1,
                                  ),
                                  dropdownColor: darkMode
                                      ? const Color.fromARGB(255, 40, 40, 40)
                                      : const Color.fromARGB(
                                          255, 229, 242, 250),
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
                      height: height / 40,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: wordCount,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: height / 60,
                        );
                      },
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(height / 100),
                            color: darkMode
                                ? const Color.fromARGB(255, 55, 55, 55)
                                : color4,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(height / 100),
                            child: Column(
                              children: [
                                BasicTextField(
                                  textFieldData: definitions[i],
                                  hintError:
                                      language["Definition can't be blank"],
                                  colorBorder: color1,
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
                        );
                      },
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    Align(
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: color1,
                            foregroundColor: Colors.white),
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
                );
              }
              return Container(
                color: const Color.fromARGB(255, 40, 40, 40),
                child: Center(
                    child: CircularProgressIndicator(
                        color: darkMode ? Colors.white : color1)),
              );
            },
          ),
        ),
      ),
    );
  }

  onPressed() async {
    bool error = false;
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
      }
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
      await APIQuizzes().httpPatchQuiz(
          mapQuiz(title.input.text, description.input.text, "public", definitionLanguage.toString(),
              answerLanguage.toString(), definitions, answers),
          widget.uuid);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      widget.refresh;
    }
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
}
