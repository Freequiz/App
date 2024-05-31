import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/conditional.dart';

class Username extends StatefulWidget {
  final Map data;
  final Function refresh;
  const Username({super.key, required this.data, required this.refresh});

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  bool edit = false;
  TextFieldData newUsername = TextFieldData(hint: 'username'.tr());

  @override
  Widget build(BuildContext context) {
    final textColor = DeviceInfo.darkMode
        ? Colors.white
        : gray40;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
        color: DeviceInfo.darkMode ? gray55 : white235,
      ),
      child: Padding(
        padding: EdgeInsets.all(DeviceInfo().height() / 100),
        child: Column(
          children: [
            Row(
              children: [
                const Text('username').tr(),
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
            Conditional(
              condition: edit,
              widget: SizedBox(height: DeviceInfo().height() / 60),
            ),
            Conditional(
              condition: edit,
              widget: Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      height: DeviceInfo().height() / 20,
                      child: TextField(
                        onSubmitted: (value) {
                          changeUsername();
                        },
                        keyboardAppearance: DeviceInfo.darkMode
                            ? Brightness.dark
                            : Brightness.light,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        controller: newUsername.input,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: DeviceInfo.darkMode
                              ? const Color.fromARGB(255, 45, 45, 45)
                              : const Color.fromARGB(255, 255, 231, 218),
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: newUsername.hint,
                          hintStyle: TextStyle(
                            color: newUsername.error
                                ? Colors.red
                                : (newUsername.changed
                                    ? Colors.green
                                    : textColor),
                          ),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: newUsername.color,
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
                    height: DeviceInfo().height() / 20,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: grayFreequiz,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        changeUsername();
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

  changeUsername() async {
    final Map map =
        await APIUsers.updateAccount(username: newUsername.input.text);
    if (map["success"] == true) {
      setState(() {
        newUsername.input.clear();
        newUsername.hint = 'username change'.tr();
        newUsername.color = Colors.green;
        newUsername.error = false;
        newUsername.changed = true;
      });
      widget.refresh();
    } else if (map["message"] == "Invalid Username") {
      setState(() {
        newUsername.input.clear();
        newUsername.hint = 'username invalid'.tr();
        newUsername.color = Colors.red;
        newUsername.error = true;
        newUsername.changed = false;
      });
    } else if (map["message"] == "Username is taken") {
      setState(() {
        newUsername.input.clear();
        newUsername.hint = 'username taken'.tr();
        newUsername.color = Colors.red;
        newUsername.error = true;
        newUsername.changed = false;
      });
    }
  }
}
