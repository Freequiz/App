import 'package:flutter/material.dart';
import 'package:freequiz/api/api_account.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/others/style.dart';

class Login extends StatefulWidget {
  final Function refresh;
  const Login({super.key, required this.refresh});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool wrongUsername = false;
  bool wrongPassword = false;
  bool showPassword = false;

  late Map mapLogin;
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final hintColor = darkMode ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(
        title: Text(language["Sign up"]),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height / 60,
              ),
              Text(
                language["Login"],
                style: TextStyle(fontSize: height / 20),
              ),
              SizedBox(
                height: height / 60,
              ),
              SizedBox(
                height: height / 20,
                child: TextField(
                  onSubmitted: (value) {
                    setState(() {
                      myFocusNode.requestFocus();
                      wrongUsername = false;
                    });
                  },
                  keyboardAppearance:
                              darkMode ? Brightness.dark : Brightness.light,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: username,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    hintStyle: TextStyle(
                      color: wrongUsername ? Colors.red : hintColor,
                    ),
                    hintText: wrongUsername
                        ? language["Username not found"]
                        : language["Username"],
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: wrongUsername ? Colors.red : color1,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
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
                        focusNode: myFocusNode,
                        controller: password,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          hintStyle: TextStyle(
                            color: wrongPassword ? Colors.red : hintColor,
                          ),
                          hintText:
                              wrongPassword ? language["Wrong Password"] : language["Password"],
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
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: wrongPassword ? Colors.red : color1,
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
                        onPressed();
                      },
                      child: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressed() async {
    mapLogin = await httpPostSession(
      username.text.trim(),
      password.text.trim()
    );
    if (mapLogin.isNotEmpty) {
      if (mapLogin["message"] == "User not found") {
        setState(() {
          wrongUsername = true;
          username.clear();
        });
      } else if (mapLogin["message"] == "Wrong password") {
        setState(() {
          wrongPassword = true;
          password.clear();
        });
      } else {
        Profile.accessToken = mapLogin["access_token"];
        Profile().saveData();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        widget.refresh();
      }
    }
  }
}
