import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/textfield_data.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

import '../../others/utilities.dart';

class Password extends StatefulWidget {
  final Function refresh;
  const Password({super.key, required this.refresh});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextFieldData newPassword =
      TextFieldData(hint: language["Password"], shown: false);
  TextFieldData newPasswordConfirmation =
      TextFieldData(hint: language["Confirm Password"], shown: false);
  TextFieldData oldPassword =
      TextFieldData(hint: language["Old Password"], shown: false);
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    final textColor = DeviceInfo.darkMode ? Colors.white : textGray;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
        color: DeviceInfo.darkMode ? backgroundGray : backgroundWhite,
      ),
      child: Padding(
        padding: EdgeInsets.all(DeviceInfo().height() / 100),
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
            conditional(
              edit,
              SizedBox(height: DeviceInfo().height() / 60),
            ),
            conditional(
              edit,
              SizedBox(
                height: DeviceInfo().height() / 20,
                child: TextField(
                  onSubmitted: (value) {
                    FocusScope.of(context).nextFocus();
                  },
                  keyboardAppearance:
                      DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  enableSuggestions: false,
                  obscureText: !oldPassword.shown,
                  keyboardType: TextInputType.visiblePassword,
                  controller: oldPassword.input,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: DeviceInfo.darkMode
                        ? const Color.fromARGB(255, 45, 45, 45)
                        : const Color.fromARGB(255, 255, 231, 218),
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: oldPassword.hint,
                    hintStyle: TextStyle(
                      color: newPassword.error ? Colors.red : textColor,
                    ),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: newPassword.color,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        oldPassword.shown
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: grayFreequiz,
                      ),
                      onPressed: () {
                        setState(() {
                          oldPassword.shown = !oldPassword.shown;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            conditional(edit, Space.height(5.0)),
            conditional(
              edit,
              SizedBox(
                height: DeviceInfo().height() / 20,
                child: TextField(
                  onSubmitted: (value) {
                    FocusScope.of(context).nextFocus();
                  },
                  keyboardAppearance:
                      DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  enableSuggestions: false,
                  obscureText: !newPassword.shown,
                  keyboardType: TextInputType.visiblePassword,
                  controller: newPassword.input,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: DeviceInfo.darkMode
                        ? const Color.fromARGB(255, 45, 45, 45)
                        : const Color.fromARGB(255, 255, 231, 218),
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: newPassword.hint,
                    hintStyle: TextStyle(
                      color: newPassword.error ? Colors.red : textColor,
                    ),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: newPassword.color,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        newPassword.shown
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: grayFreequiz,
                      ),
                      onPressed: () {
                        setState(() {
                          newPassword.shown = !newPassword.shown;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            conditional(
              edit,
              Space.height(5.0),
            ),
            conditional(
              edit,
              Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      height: DeviceInfo().height() / 20,
                      child: TextField(
                        onSubmitted: (value) {
                          changePassword();
                        },
                        keyboardAppearance: DeviceInfo.darkMode
                            ? Brightness.dark
                            : Brightness.light,
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: !newPasswordConfirmation.shown,
                        keyboardType: TextInputType.visiblePassword,
                        controller: newPasswordConfirmation.input,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: DeviceInfo.darkMode
                              ? const Color.fromARGB(255, 45, 45, 45)
                              : const Color.fromARGB(255, 255, 231, 218),
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: newPasswordConfirmation.hint,
                          hintStyle: TextStyle(
                            color: newPassword.error ? Colors.red : textColor,
                          ),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: newPassword.color,
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              newPasswordConfirmation.shown
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: grayFreequiz,
                            ),
                            onPressed: () {
                              setState(() {
                                newPasswordConfirmation.shown =
                                    !newPasswordConfirmation.shown;
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
                    height: DeviceInfo().height() / 20,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: grayFreequiz,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        changePassword();
                      },
                      child: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  changePassword() async {
    final Map map = await APIUsers.updateAccount(
        password: newPassword.input.text,
        passwordConfirmation: newPasswordConfirmation.input.text,
        oldPassword: oldPassword.input.text);
    if (map["success"] == true) {
      setState(() {
        newPassword.input.clear();
        newPasswordConfirmation.input.clear();
        oldPassword.input.clear();
        oldPassword.hint = language["Password changed"];
        newPassword.hint = language["successfully"];
        newPasswordConfirmation.hint = language[""];
        newPassword.color = Colors.green;
      });
    } else if (map["message"] == "Passwords don't match") {
      setState(() {
        newPassword.input.clear();
        newPasswordConfirmation.input.clear();
        newPassword.hint = language["Passwords don't match"];
        newPasswordConfirmation.hint = "";
        newPassword.color = Colors.red;
        newPassword.error = true;
      });
    } else if (map["message"] == "New password doesn't meet requirements") {
      setState(() {
        newPassword.input.clear();
        newPasswordConfirmation.input.clear();
        newPassword.hint =
            language["At least 8 characters long, capital letter,"];
        newPasswordConfirmation.hint = language["lowercase letter and number"];
        newPassword.color = Colors.red;
        newPassword.error = true;
      });
    }
  }
}
