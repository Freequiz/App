import 'package:flutter/material.dart';
import 'package:freequiz/api/api_account.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class EMail extends StatefulWidget {
  final Function refresh;
  final Map data;
  const EMail({super.key, required this.data, required this.refresh});

  @override
  State<EMail> createState() => _EMailState();
}

class _EMailState extends State<EMail> {
  bool eMailChanged = false;
  final newEmail = TextEditingController();
  String emailHint = language["E-Mail"];
  bool errorEmail = false;
  Color emailTextfieldColor = color1;
  bool successEmail = false;
  final color5 = const Color.fromARGB(255, 50, 50, 50);
  final color6 = color3;
  bool edit = false;

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
                Text(language["E-Mail"]),
                const Spacer(),
                Text(widget.data["data"]["email"]),
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
                              changeEmail();
                            },
                            keyboardAppearance:
                                darkMode ? Brightness.dark : Brightness.light,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            controller: newEmail,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: darkMode
                                  ? const Color.fromARGB(255, 45, 45, 45)
                                  : const Color.fromARGB(255, 255, 231, 218),
                              contentPadding: const EdgeInsets.all(10.0),
                              hintText: emailHint,
                              hintStyle: TextStyle(
                                color: errorEmail
                                    ? Colors.red
                                    : (successEmail ? Colors.green : textColor),
                              ),
                              border: const OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: emailTextfieldColor,
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
                            changeEmail();
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

  changeEmail() async {
    final Map map = await httpPatchAccount(email: newEmail.text);
    if (map["success"] == true) {
      setState(() {
        newEmail.clear();
        emailHint = language["E-Mail changed succesfully"];
        emailTextfieldColor = Colors.green;
        errorEmail = false;
        successEmail = true;
      });
      widget.refresh();
    } else if (map["message"] == "Invalid email") {
      setState(() {
        newEmail.clear();
        emailHint = language["Invalid E-Mail"];
        emailTextfieldColor = Colors.red;
        errorEmail = true;
        successEmail = false;
      });
    } else if (map["message"] == "Email is taken") {
      setState(() {
        newEmail.clear();
        emailHint = language["Email is taken"];
        emailTextfieldColor = Colors.red;
        errorEmail = true;
        successEmail = false;
      });
    }
  }
}
