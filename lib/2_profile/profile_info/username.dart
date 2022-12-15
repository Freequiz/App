import 'package:flutter/material.dart';
import 'package:freequiz/api/api_account.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class Username extends StatefulWidget {
  final Map data;
  final Function refresh;
  const Username({super.key, required this.data, required this.refresh});

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  final color5 = const Color.fromARGB(255, 50, 50, 50);
  final color6 = color3;
  bool edit = false;
  final newUsername = TextEditingController();
  String usernameHint = language["Username"];
  bool errorUsername = false;
  Color usernameTextfieldColor = color1;
  bool successUsername = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final textColor =
        darkMode ? Colors.white : const Color.fromARGB(255, 40, 40, 40);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / 100),
        color: darkMode ? color5 : color6,
      ),
      child: Padding(
        padding: EdgeInsets.all(height / 100),
        child: Column(
          children: [
            Row(
              children: [
                Text(language["Username"]),
                const Spacer(),
                Text(widget.data["data"]["username"]),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      edit = !edit;
                    });
                  },
                  child: Icon(
                    edit ? Icons.clear : Icons.edit,
                    color: textColor,
                  ),
                ),
              ],
            ),
            edit
                ? SizedBox(height: height / 60)
                : const SizedBox(
                    height: 0,
                  ),
            edit
                ? Row(
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: height / 20,
                          child: TextField(
                            onSubmitted: (value) {
                              changeUsername();
                            },
                            keyboardAppearance:
                                darkMode ? Brightness.dark : Brightness.light,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            controller: newUsername,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: darkMode
                                  ? const Color.fromARGB(255, 45, 45, 45)
                                  : const Color.fromARGB(255, 255, 231, 218),
                              contentPadding: const EdgeInsets.all(10.0),
                              hintText: usernameHint,
                              hintStyle: TextStyle(
                                color: errorUsername
                                    ? Colors.red
                                    : (successUsername
                                        ? Colors.green
                                        : textColor),
                              ),
                              border: const OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: usernameTextfieldColor,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: height / 20,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: color1,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            changeUsername();
                          },
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 0,
                  ),
          ],
        ),
      ),
    );
  }

  changeUsername() async {
    final Map map = await httpPatchAccount(username: newUsername.text);
    if (map["success"] == true) {
      setState(() {
        newUsername.clear();
        usernameHint = language["Username changed successfully"];
        usernameTextfieldColor = Colors.green;
        errorUsername = false;
        successUsername = true;
      });
      widget.refresh();
    } else if (map["message"] == "Invalid Username") {
      setState(() {
        newUsername.clear();
        usernameHint = language["Username is not valid"];
        usernameTextfieldColor = Colors.red;
        errorUsername = true;
        successUsername = false;
      });
    } else if (map["message"] == "Username is taken") {
      setState(() {
        newUsername.clear();
        usernameHint = language["Username is taken"];
        usernameTextfieldColor = Colors.red;
        errorUsername = true;
        successUsername = false;
      });
    }
  }
}
