import 'package:flutter/material.dart';
import 'package:freequiz/api/convert_json.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  int wordCount = 3;
  List errorDefinitions = [false, false, false];
  List errorAnswers = [false, false, false];
  String definitionLanguage = "German";
  String answerLanguage = "English";
  bool errorTitle = false;
  bool errorDescription = false;
  final List definitions = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  final List answers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  final List<DropdownMenuItem<String>> languages = [
    DropdownMenuItem(
      value: "German",
      child: Text(language["German"]),
    ),
    DropdownMenuItem(
      value: "English",
      child: Text(language["English"]),
    ),
    DropdownMenuItem(
      value: "French",
      child: Text(language["French"]),
    ),
    DropdownMenuItem(
      value: "Italian",
      child: Text(language["Italian"]),
    ),
  ];
  final title = TextEditingController();
  final description = TextEditingController();

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
        title: Text(language["Create Quiz"]),
        backgroundColor: darkMode ? color1 : color4,
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
          padding: mobileLayout ? const EdgeInsets.all(10.0) : EdgeInsets.symmetric(horizontal: width / 5.5, vertical: 10.0),
          child: ListView(
            children: [
              SizedBox(
                height: height / 60,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 100),
                  color:
                      darkMode ? const Color.fromARGB(255, 55, 55, 55) : color4,
                ),
                child: Padding(
                  padding: EdgeInsets.all(height / 100),
                  child: Column(
                    children: [
                      TextField(
                        onSubmitted: (value) {
                          FocusScope.of(context).nextFocus();
                        },
                        onChanged: (value) {
                          setState(() {
                            errorTitle = false;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {},
                        controller: title,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: darkMode
                              ? const Color.fromARGB(255, 45, 45, 45)
                              : const Color.fromARGB(255, 234, 247, 255),
                          contentPadding: const EdgeInsets.all(10.0),
                          hintStyle: TextStyle(
                            color: errorTitle ? Colors.red : hintColor,
                            fontWeight: FontWeight.w500,
                          ),
                          hintText: errorTitle
                              ? language["Title can't be blank"]
                              : language["Title"],
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: errorTitle
                                  ? Colors.red
                                  : (darkMode ? color3 : color1),
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        onSubmitted: (value) {
                          FocusScope.of(context).nextFocus();
                        },
                        onChanged: (value) {
                          setState(() {
                            errorDescription = false;
                          });
                        },
                        textInputAction: TextInputAction.newline,
                        onEditingComplete: () {},
                        controller: description,
                        maxLines: 6,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: darkMode
                              ? const Color.fromARGB(255, 45, 45, 45)
                              : const Color.fromARGB(255, 234, 247, 255),
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: errorDescription
                              ? language["Description can't be blank"]
                              : language["Description"],
                          hintStyle: TextStyle(
                            color: errorDescription ? Colors.red : hintColor,
                          ),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: errorDescription ? Colors.red : color1,
                              width: 2.0,
                            ),
                          ),
                        ),
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
                                : const Color.fromARGB(255, 229, 242, 250),
                            items: languages,
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
                                : const Color.fromARGB(255, 229, 242, 250),
                            items: languages,
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
                          TextField(
                            onSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            onChanged: (value) {
                              setState(() {
                                errorDefinitions[i] = false;
                              });
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {},
                            autocorrect: false,
                            controller: definitions[i],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: darkMode
                                  ? const Color.fromARGB(255, 45, 45, 45)
                                  : const Color.fromARGB(255, 234, 247, 255),
                              contentPadding: const EdgeInsets.all(10.0),
                              hintStyle: TextStyle(
                                color: errorDefinitions[i]
                                    ? Colors.red
                                    : hintColor,
                              ),
                              hintText: errorDefinitions[i]
                                  ? language["Definition can't be blank"]
                                  : language["Definition"],
                              border: const OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      errorDefinitions[i] ? Colors.red : color1,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            onSubmitted: (value) {
                              setState(() {
                                if (definitions[i].text != "" &&
                                    answers[i].text != "") {
                                  if (i + 2 >= wordCount) {
                                    wordCount++;
                                    definitions.add(TextEditingController());
                                    answers.add(TextEditingController());
                                    errorAnswers.add(false);
                                    errorDefinitions.add(false);
                                  }
                                  FocusScope.of(context).nextFocus();
                                }
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                errorAnswers[i] = false;
                              });
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {},
                            autocorrect: false,
                            controller: answers[i],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: darkMode
                                  ? const Color.fromARGB(255, 45, 45, 45)
                                  : const Color.fromARGB(255, 234, 247, 255),
                              contentPadding: const EdgeInsets.all(10.0),
                              hintStyle: TextStyle(
                                color: errorAnswers[i] ? Colors.red : hintColor,
                              ),
                              hintText: errorAnswers[i]
                                  ? language["Answer can't be blank"]
                                  : language["Answer"],
                              border: const OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: errorAnswers[i] ? Colors.red : color1,
                                  width: 2.0,
                                ),
                              ),
                            ),
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
                      backgroundColor: color1, foregroundColor: Colors.white),
                  onPressed: () {
                    setState(() {
                      wordCount++;
                      definitions.add(TextEditingController());
                      answers.add(TextEditingController());
                      errorAnswers.add(false);
                      errorDefinitions.add(false);
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

  onPressed() {
    bool error = false;
    for (var i = 0; i < definitions.length; i++) {
      if (definitions[i].text.replaceAll(' ', '') == "") {
        if (answers[i].text.replaceAll(' ', '') != "") {
          setState(() {
            errorDefinitions[i] = true;
            definitions[i].clear();
            error = true;
          });
        }
      } else if (answers[i].text.replaceAll(' ', '') == "") {
        if (definitions[i].text.replaceAll(' ', '') != "") {
          setState(() {
            errorAnswers[i] = true;
            answers[i].clear();
            error = true;
          });
        }
      }
    }
    if (title.text.replaceAll(' ', '') == "") {
      errorTitle = true;
      error = true;
      title.clear();
    }
    if (description.text.replaceAll(' ', '') == "") {
      errorDescription = true;
      error = true;
      description.clear();
    }
    if (!error) {
      map(title.text, description.text, definitionLanguage, answerLanguage,
          definitions, answers);
    }
  }
}
