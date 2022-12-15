import 'package:flutter/material.dart';
import 'package:freequiz/api/api_account.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class Password extends StatefulWidget {
  final Function refresh;
  const Password({super.key, required this.refresh});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final newPassword = TextEditingController();
  final newPasswordConfirmation = TextEditingController();
  final oldPassword = TextEditingController();
  String passwordHint = language["Password"];
  Color passwordTextfieldColor = color1;
  String passwordConfirmationHint = language["Confirm Password"];
  String oldPasswordHint = language["Old Password"];
  bool passwordChanged = false;
  bool showOldPassword = false;
  bool showPassword = false;
  bool showPasswordConfirmation = false;
  bool errorPassword = false;
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
                Text(language["Password"]),
                const Spacer(),
                const Text("· · · · · · · ·"),
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
                ? SizedBox(
                    height: height / 20,
                    child: TextField(
                      onSubmitted: (value) {
                        FocusScope.of(context).nextFocus();
                      },
                      keyboardAppearance:
                          darkMode ? Brightness.dark : Brightness.light,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: !showOldPassword,
                      keyboardType: TextInputType.visiblePassword,
                      controller: oldPassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: darkMode
                            ? const Color.fromARGB(255, 45, 45, 45)
                            : const Color.fromARGB(255, 255, 231, 218),
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: oldPasswordHint,
                        hintStyle: TextStyle(
                          color: errorPassword ? Colors.red : textColor,
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: passwordTextfieldColor,
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showOldPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: color1,
                          ),
                          onPressed: () {
                            setState(() {
                              showOldPassword = !showOldPassword;
                            });
                          },
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            edit
                ? const SizedBox(
                    height: 5.0,
                  )
                : const SizedBox(
                    height: 0,
                  ),
            edit
                ? SizedBox(
                    height: height / 20,
                    child: TextField(
                      onSubmitted: (value) {
                        FocusScope.of(context).nextFocus();
                      },
                      keyboardAppearance:
                          darkMode ? Brightness.dark : Brightness.light,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: !showPassword,
                      keyboardType: TextInputType.visiblePassword,
                      controller: newPassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: darkMode
                            ? const Color.fromARGB(255, 45, 45, 45)
                            : const Color.fromARGB(255, 255, 231, 218),
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: passwordHint,
                        hintStyle: TextStyle(
                          color: errorPassword ? Colors.red : textColor,
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: passwordTextfieldColor,
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: color1,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            edit
                ? const SizedBox(
                    height: 5.0,
                  )
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
                              changePassword();
                            },
                            keyboardAppearance:
                                darkMode ? Brightness.dark : Brightness.light,
                            autocorrect: false,
                            enableSuggestions: false,
                            obscureText: !showPasswordConfirmation,
                            keyboardType: TextInputType.visiblePassword,
                            controller: newPasswordConfirmation,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: darkMode
                                  ? const Color.fromARGB(255, 45, 45, 45)
                                  : const Color.fromARGB(255, 255, 231, 218),
                              contentPadding: const EdgeInsets.all(10.0),
                              hintText: passwordConfirmationHint,
                              hintStyle: TextStyle(
                                color: errorPassword ? Colors.red : textColor,
                              ),
                              border: const OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: passwordTextfieldColor,
                                  width: 2.0,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showPasswordConfirmation
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: color1,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showPasswordConfirmation =
                                        !showPasswordConfirmation;
                                  });
                                },
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
                            changePassword();
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

  changePassword() async {
    final Map map = await httpPatchAccount(
        password: newPassword.text,
        passwordConfirmation: newPasswordConfirmation.text,
        oldPassword: oldPassword.text);
    if (map["success"] == true) {
      setState(() {
        newPassword.clear();
        newPasswordConfirmation.clear();
        oldPassword.clear();
        oldPasswordHint = language["Password changed"];
        passwordHint = language["successfully"];
        passwordConfirmationHint = language[""];
        passwordTextfieldColor = Colors.green;
      });
    } else if (map["message"] == "Passwords don't match") {
      setState(() {
        newPassword.clear();
        newPasswordConfirmation.clear();
        passwordHint = language["Passwords don't match"];
        passwordConfirmationHint = "";
        passwordTextfieldColor = Colors.red;
        errorPassword = true;
      });
    } else if (map["message"] == "New password doesn't meet requirements") {
      setState(() {
        newPassword.clear();
        newPasswordConfirmation.clear();
        passwordHint = language["At least 8 characters long, capital letter,"];
        passwordConfirmationHint = language["lowercase letter and number"];
        passwordTextfieldColor = Colors.red;
        errorPassword = true;
      });
    }
  }
}
