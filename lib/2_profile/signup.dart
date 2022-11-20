import 'package:flutter/material.dart';
import 'package:freequiz/api/api.dart';
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
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirmation = TextEditingController();
  bool showPassword = false;
  bool showPasswordConfirmation = false;
  String usernameHint = language["Username"];
  String emailHint = language["E-Mail"];
  String passwordHint = language["Password"];
  String passwordConfirmationHint = language["Confirm Password"];
  bool errorUsername = false;
  bool errorEmail = false;
  bool errorPassword = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final hintColor = darkMode ? Colors.white : Colors.black;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SizedBox(
              height: height / 60,
            ),
            Center(
              child: Text(
                language["Sign up"],
                style: TextStyle(fontSize: height / 20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  language["By signing up you accept the"],
                  style: TextStyle(fontSize: height / 65),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    language["terms and conditions"],
                    style: TextStyle(fontSize: height / 65),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height / 20,
              child: TextField(
                onSubmitted: (value) {
                  FocusScope.of(context).nextFocus();
                },
                textInputAction: TextInputAction.next,
                keyboardAppearance:
                              darkMode ? Brightness.dark : Brightness.light,
                keyboardType: TextInputType.name,
                controller: username,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  hintText: usernameHint,
                  hintStyle: TextStyle(
                    color: errorUsername ? Colors.red : hintColor,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: errorUsername ? Colors.red : color1,
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
              height: height / 20,
              child: TextField(
                onSubmitted: (value) {
                  FocusScope.of(context).nextFocus();
                },
                keyboardAppearance:
                              darkMode ? Brightness.dark : Brightness.light,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                controller: email,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  hintText: emailHint,
                  hintStyle: TextStyle(
                    color: errorEmail ? Colors.red : hintColor,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: errorEmail ? Colors.red : color1,
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
                controller: password,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  hintText: passwordHint,
                  hintStyle: TextStyle(
                    color: errorPassword ? Colors.red : hintColor,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: errorPassword ? Colors.red : color1,
                      width: 2.0,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
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
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Flexible(
                  child: SizedBox(
                    height: height / 20,
                    child: TextField(
                      onSubmitted: (value) {
                        onPressed();
                      },
                      keyboardAppearance:
                              darkMode ? Brightness.dark : Brightness.light,
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: !showPasswordConfirmation,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordConfirmation,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: passwordConfirmationHint,
                        hintStyle: TextStyle(
                          color: errorPassword ? Colors.red : hintColor,
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: errorPassword ? Colors.red : color1,
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
                      onPressed();
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 60,
            ),
            Center(
              child: Text(
                language["Already have an Account?"],
                style: TextStyle(fontSize: height / 65),
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
    final Map map = await httpPutAccount(username.text, email.text,
        password.text, passwordConfirmation.text, true);
    if (map["success"] == true) {
      Profile.sessionToken = map["session"]["token"];
      Profile.date = map["session"]["expire"];
      Profile().saveData();
      widget.refresh();
    } else if (map["message"] == "Username is already taken") {
      setState(() {
        username.clear();
        usernameHint = language["Username is taken"];
        errorUsername = true;
      });
    } else if (map["message"] == "Username doesn't meet requirements") {
      setState(() {
        username.clear();
        usernameHint = language["Username is not valid"];
        errorUsername = true;
      });
    } else if (map["message"] == "Email is already taken") {
      setState(() {
        email.clear();
        emailHint = language["E-Mail is taken"];
        errorEmail = true;
      });
    } else if (map["message"] == "Email doesn't meet requirements") {
      setState(() {
        email.clear();
        emailHint = language["E-Mail is invalid"];
        errorEmail = true;
      });
    } else if (map["message"] == "Password don't match") {
      setState(() {
        password.clear();
        passwordConfirmation.clear();
        passwordHint = language["Passwords don't match"];
        passwordConfirmationHint = "";
        errorPassword = true;
      });
    } else if (map["message"] == "Password doesn't meet requirements") {
      setState(() {
        password.clear();
        passwordConfirmation.clear();
        passwordHint = language["At least 8 characters long, capital letter,"];
        passwordConfirmationHint = language["lowercase letter and number"];
        errorPassword = true;
      });
    }
  }
}
