import 'package:flutter/material.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/textfield_data.dart';

class BugReporter extends StatefulWidget {
  const BugReporter({super.key});

  @override
  State<BugReporter> createState() => _BugReporterState();
}

class _BugReporterState extends State<BugReporter> {
  TextFieldData title = TextFieldData(hint: "");
  TextFieldData description = TextFieldData(hint: "");
  TextFieldData platform = TextFieldData(hint: "");

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final hintColor =
        darkMode ? Colors.white : const Color.fromARGB(255, 40, 40, 40);
    return Scaffold(
      appBar: AppBar(
        title: Text(language["Bug Reporter"]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
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
                          title.error = false;
                        });
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {},
                      controller: title.input,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: darkMode
                            ? const Color.fromARGB(255, 45, 45, 45)
                            : const Color.fromARGB(255, 234, 247, 255),
                        contentPadding: const EdgeInsets.all(10.0),
                        hintStyle: TextStyle(
                          color: title.error ? Colors.red : hintColor,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: title.error
                            ? language["Title can't be blank"]
                            : language["Title"],
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: title.error
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
                          description.error = false;
                        });
                      },
                      textInputAction: TextInputAction.newline,
                      onEditingComplete: () {},
                      controller: description.input,
                      minLines: 6,
                      maxLines: 16,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: darkMode
                            ? const Color.fromARGB(255, 45, 45, 45)
                            : const Color.fromARGB(255, 234, 247, 255),
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: description.error
                            ? language["Description can't be blank"]
                            : language["Description"],
                        hintStyle: TextStyle(
                          color: description.error ? Colors.red : hintColor,
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: description.error ? Colors.red : color1,
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
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (value) {
                        setState(() {
                          platform.error = false;
                        });
                      },
                      textInputAction: TextInputAction.newline,
                      onEditingComplete: () {},
                      controller: platform.input,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: darkMode
                            ? const Color.fromARGB(255, 45, 45, 45)
                            : const Color.fromARGB(255, 234, 247, 255),
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: platform.error
                            ? language["Platform can't be blank"]
                            : language["Platform"],
                        hintStyle: TextStyle(
                          color: platform.error ? Colors.red : hintColor,
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: platform.error ? Colors.red : color1,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 40,
            ),
            Align(
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: color1, foregroundColor: Colors.white),
                onPressed: () {},
                child: Text(
                  language["Submit"],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
