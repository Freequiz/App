import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/buttons/submit.dart';
import 'package:freequiz/_views/textfields/email.dart';
import 'package:freequiz/_views/textfields/password.dart';
import 'package:freequiz/_views/textfields/password_confirmation.dart';
import 'package:freequiz/_views/textfields/username.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/2_profile/login.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/utilities.dart';

class SignUp extends StatefulWidget {
  final Function refresh;
  const SignUp({super.key, required this.refresh});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextFieldData username = TextFieldData(hint: 'username'.tr());
  TextFieldData email = TextFieldData(hint: 'email'.tr());
  TextFieldData password = TextFieldData(hint: 'password'.tr(), shown: false);
  TextFieldData passwordConfirmation = TextFieldData(hint: 'confirm password'.tr(), shown: false);
  bool pressed = false;

  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
        padding: DeviceInfo.mobileLayout
            ? const EdgeInsets.all(10.0)
            : EdgeInsets.symmetric(horizontal: DeviceInfo().width() / 5.5, vertical: 10.0),
        child: Column(
          children: [
            SizedBox(
              height: DeviceInfo().height() / 15,
            ),
            Center(
              child: Text(
                context.tr('sign up'),
                style: textSize(DeviceInfo().height() / 20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.tr('terms 1'),
                  style: textSize(DeviceInfo().height() / 65),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Text(
                    context.tr('terms 2'),
                    style: TextStyle(fontSize: DeviceInfo().height() / 65, color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: DeviceInfo().height() / 40.0,
            ),
            UsernameTextfield(username: username, focusNode: focusNode),
            const SizedBox(
              height: 5.0,
            ),
            EmailTextfield(email: email, focusNode: focusNode),
            const SizedBox(
              height: 5.0,
            ),
            PasswordTextfield(
              password: password,
              onPressed: () {
                focusNode.requestFocus();
                setState(() {
                  password.error = false;
                });
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Flexible(
                  child: PasswordConfirmationTextfield(
                    passwordConfirmation: passwordConfirmation,
                    onPressed: onPressed,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SubmitButton(pressed: pressed, onPressed: onPressed)
              ],
            ),
            SizedBox(
              height: DeviceInfo().height() / 60,
            ),
            Center(
              child: Text(
                context.tr('already account'),
                style: textSize(DeviceInfo().height() / 65),
              ),
            ),
            Align(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: grayFreequiz,
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
                child: const Text('log in').tr(),
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
        password.hint = 'password dont match'.tr();
        passwordConfirmation.hint = "";
        password.error = true;
      });
    } else if (username.input.text.isEmpty) {
      setState(() {
        username.hint = 'blank'.tr();
        username.error = true;
      });
    } else if (email.input.text.isEmpty) {
      setState(() {
        email.hint = 'blank'.tr();
        email.error = true;
      });
    } else if (password.input.text.isEmpty) {
      setState(() {
        password.hint = 'blank'.tr();
        passwordConfirmation.hint = "";
      });
    } else {
      setState(() {
        pressed = true;
      });
      final Map map = await APIUsers.createAccount(
          username.input.text, email.input.text, password.input.text, passwordConfirmation.input.text, true);
      //throw new Exception("Hallo Nithus");
      if (map["success"] == true) {
        Profile.accessToken = map["access_token"];
        Profile.saveData();
        widget.refresh();
      } else if (map["token"] == "password.invalid") {
        setState(() {
          password.input.clear();
          passwordConfirmation.input.clear();
          password.hint = 'password length 1'.tr();
          passwordConfirmation.hint = 'password length 2'.tr();
          password.error = true;
          pressed = false;
        });
      } else if (map["token"] == "record.invalid") {
        map["errors"].forEach((object, error) {
          String errorMessage = "$object.${error[0]['error']!}".tr();

          switch (object) {
            case "username":
              setState(() {
                username.input.clear();
                username.hint = errorMessage;
                username.error = true;
                pressed = false;
              });
              break;
            case "email":
              setState(() {
                email.input.clear();
                email.hint = errorMessage;
                email.error = true;
                pressed = false;
              });
              break;
            default:
              throw Exception("No matching Error");
          }
        });
      } else {
        throw Exception("Error not handled");
      }
    }
  }
}
