import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/textfield_data.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/utilities.dart';

class Login extends StatefulWidget {
  final Function refresh;
  const Login({super.key, required this.refresh});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextFieldData username = TextFieldData(hint: "");
  final password = TextFieldData(hint: "", shown: false);
  bool pressed = false;

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
    final hintColor = DeviceInfo.darkMode ? Colors.white : Colors.black;
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
          padding: DeviceInfo.mobileLayout
              ? const EdgeInsets.all(10.0)
              : EdgeInsets.symmetric(
                  horizontal: DeviceInfo().width() / 5.5, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Space.height(DeviceInfo().height() / 60),
              Text(
                language["Login"],
                style: textSize(DeviceInfo().height() / 20),
              ),
              Space.height(DeviceInfo().height() / 60),
              SizedBox(
                height:
                    DeviceInfo.mobileLayout ? DeviceInfo().height() / 20 : 40,
                child: TextField(
                  onSubmitted: (value) {
                    setState(() {
                      myFocusNode.requestFocus();
                      username.error = false;
                    });
                  },
                  keyboardAppearance:
                      DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: username.input,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    hintStyle: TextStyle(
                      color: username.error ? Colors.red : hintColor,
                    ),
                    hintText: username.error
                        ? language["Username not found"]
                        : language["Username"],
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
              Space.height(5),
              Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      height: DeviceInfo.mobileLayout
                          ? DeviceInfo().height() / 20
                          : 40,
                      child: TextField(
                        onSubmitted: (value) {
                          onPressed();
                        },
                        keyboardAppearance: DeviceInfo.darkMode
                            ? Brightness.dark
                            : Brightness.light,
                        focusNode: myFocusNode,
                        controller: password.input,
                        obscureText: !password.shown,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          hintStyle: TextStyle(
                            color: password.error ? Colors.red : hintColor,
                          ),
                          hintText: password.error
                              ? language["Wrong Password"]
                              : language["Password"],
                          suffixIcon: IconButton(
                            icon: Icon(
                              password.shown
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: color1,
                            ),
                            onPressed: () {
                              setState(() {
                                password.shown = !password.shown;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: password.error ? Colors.red : color1,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Space.width(5),
                  SizedBox(
                    height: DeviceInfo.mobileLayout
                        ? DeviceInfo().height() / 20
                        : 40,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: color1,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        pressed ? () {} : onPressed();
                      },
                      child: conditional(
                        pressed,
                        SizedBox(
                          width: DeviceInfo.mobileLayout
                              ? DeviceInfo().height() / 30
                              : 30,
                          height: DeviceInfo.mobileLayout
                              ? DeviceInfo().height() / 30
                              : 30,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                        defaultWidget: const Icon(Icons.arrow_forward_ios),
                      ),
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
    if (password.input.text.isEmpty) {
      setState(() {
        password.error = true;
      });
    } else if (username.input.text.isEmpty) {
      setState(() {
        username.error = true;
      });
    } else {
      setState(() {
        pressed = true;
      });
      mapLogin = await APIUsers.login(
          username.input.text.trim(), password.input.text.trim());
      if (mapLogin.isNotEmpty) {
        if (mapLogin["message"] == "User doesn't exist") {
          setState(() {
            username.error = true;
            pressed = false;
            username.input.clear();
          });
        } else if (mapLogin["message"] == "Wrong password") {
          setState(() {
            password.error = true;
            pressed = false;
            password.input.clear();
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
}
