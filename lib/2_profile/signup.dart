import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/textfield_data.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/2_profile/login.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/others/style.dart';

class SignUp extends StatefulWidget {
  final Function refresh;
  const SignUp({super.key, required this.refresh});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextFieldData username = TextFieldData(hint: language["Username"]);
  TextFieldData email = TextFieldData(hint: language["E-Mail"]);
  TextFieldData password =
      TextFieldData(hint: language["Password"], shown: false);
  TextFieldData passwordConfirmation =
      TextFieldData(hint: language["Confirm Password"], shown: false);
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final hintColor = DeviceInfo.darkMode ? Colors.white : Colors.black;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
        padding: DeviceInfo.mobileLayout
            ? const EdgeInsets.all(10.0)
            : EdgeInsets.symmetric(horizontal: DeviceInfo.width / 5.5, vertical: 10.0),
        child: ListView(
          children: [
            SizedBox(
              height: DeviceInfo.height / 60,
            ),
            Center(
              child: Text(
                language["Sign up"],
                style: TextStyle(fontSize: DeviceInfo.height / 20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  language["By signing up you accept the "],
                  style: TextStyle(fontSize: DeviceInfo.height / 65),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Text(
                    language["terms and conditions"],
                    style: TextStyle(fontSize: DeviceInfo.height / 65, color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: DeviceInfo.height / 40.0,
            ),
            SizedBox(
              height: DeviceInfo.mobileLayout ? DeviceInfo.height / 20 : 40,
              child: TextField(
                onSubmitted: (value) {
                  FocusScope.of(context).nextFocus();
                },
                textInputAction: TextInputAction.next,
                keyboardAppearance:
                    DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
                keyboardType: TextInputType.name,
                controller: username.input,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  hintText: username.hint,
                  hintStyle: TextStyle(
                    color: username.error ? Colors.red : hintColor,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: username.error ? Colors.red : color1,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: DeviceInfo.mobileLayout ? DeviceInfo.height / 20 : 40,
              child: TextField(
                onSubmitted: (value) {
                  FocusScope.of(context).nextFocus();
                },
                keyboardAppearance:
                    DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                controller: email.input,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  hintText: email.hint,
                  hintStyle: TextStyle(
                    color: email.error ? Colors.red : hintColor,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: email.error ? Colors.red : color1,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: DeviceInfo.mobileLayout ? DeviceInfo.height / 20 : 40,
              child: TextField(
                onSubmitted: (value) {
                  FocusScope.of(context).nextFocus();
                },
                keyboardAppearance:
                    DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                enableSuggestions: false,
                obscureText: !password.shown,
                keyboardType: TextInputType.visiblePassword,
                controller: password.input,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  hintText: password.hint,
                  hintStyle: TextStyle(
                    color: password.error ? Colors.red : hintColor,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: password.error ? Colors.red : color1,
                      width: 2.0,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      password.shown ? Icons.visibility : Icons.visibility_off,
                      color: color1,
                    ),
                    onPressed: () {
                      setState(() {
                        password.shown = !password.shown;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Flexible(
                  child: SizedBox(
                    height: DeviceInfo.mobileLayout ? DeviceInfo.height / 20 : 40,
                    child: TextField(
                      onSubmitted: (value) {
                        onPressed();
                      },
                      keyboardAppearance:
                          DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: !passwordConfirmation.shown,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordConfirmation.input,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: passwordConfirmation.hint,
                        hintStyle: TextStyle(
                          color: password.error ? Colors.red : hintColor,
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: password.error ? Colors.red : color1,
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordConfirmation.shown
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: color1,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordConfirmation.shown =
                                  !passwordConfirmation.shown;
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
                  height: DeviceInfo.mobileLayout ? DeviceInfo.height / 20 : 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: color1,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      pressed ? (){} : onPressed();
                    },
                    child: pressed
                        ? SizedBox(
                            width: DeviceInfo.mobileLayout ? DeviceInfo.height / 30 : 30,
                            height: DeviceInfo.mobileLayout ? DeviceInfo.height / 30 : 30,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: DeviceInfo.height / 60,
            ),
            Center(
              child: Text(
                language["Already have an Account?"],
                style: TextStyle(fontSize: DeviceInfo.height / 65),
              ),
            ),
            Align(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: color1,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Login(refresh: widget.refresh);
                      },
                    ),
                  );
                },
                child: Text(language["Log in"]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onPressed() async {
    if (password.input.text != passwordConfirmation.input.text) {
      setState(() {
        password.input.clear();
        passwordConfirmation.input.clear();
        password.hint = language["Passwords don't match"];
        passwordConfirmation.hint = "";
        password.error = true;
      });
    } else if (username.input.text.isEmpty) {
      setState(() {
        username.hint = language["Can't be blank"];
        username.error = true;
      });
    } else if (email.input.text.isEmpty) {
      setState(() {
        email.hint = language["Can't be blank"];
        email.error = true;
      });
    } else if (password.input.text.isEmpty) {
      setState(() {
        password.hint = language["Can't be blank"];
        passwordConfirmation.hint = "";
      });
    } else {
      setState(() {
        pressed = true;
      });
      final Map map = await APIUsers().httpPutAccount(
          username.input.text,
          email.input.text,
          password.input.text,
          passwordConfirmation.input.text,
          true);
      if (map["success"] == true) {
        Profile.accessToken = map["access_token"];
        Profile().saveData();
        widget.refresh();
      } else if (map["message"] == "Username is already taken") {
        setState(() {
          username.input.clear();
          username.hint = language["Username is taken"];
          username.error = true;
          pressed = false;
        });
      } else if (map["message"] == "Username doesn't meet requirements") {
        setState(() {
          username.input.clear();
          username.hint = language["Username is not valid"];
          username.error = true;
          pressed = false;
        });
      } else if (map["message"] == "Email is already taken") {
        setState(() {
          email.input.clear();
          email.hint = language["E-Mail is taken"];
          email.error = true;
          pressed = false;
        });
      } else if (map["message"] == "Email doesn't meet requirements") {
        setState(() {
          email.input.clear();
          email.hint = language["E-Mail is invalid"];
          email.error = true;
          pressed = false;
        });
      } else if (map["message"] == "Password doesn't meet requirements") {
        setState(() {
          password.input.clear();
          passwordConfirmation.input.clear();
          password.hint =
              language["At least 8 characters long, capital letter,"];
          passwordConfirmation.hint = language["lowercase letter and number"];
          password.error = true;
          pressed = false;
        });
      }
    }
  }
}
