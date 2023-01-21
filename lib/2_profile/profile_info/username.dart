import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/textfield_data.dart';
import 'package:freequiz/api/users.dart';
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
  bool edit = false;
  TextFieldData newUsername = TextFieldData(hint: language["Username"]);

  @override
  Widget build(BuildContext context) {
    final textColor =
        DeviceInfo.darkMode ? Colors.white : const Color.fromARGB(255, 40, 40, 40);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DeviceInfo.height / 100),
        color: DeviceInfo.darkMode ? backgroundGray : backgroundWhite,
      ),
      child: Padding(
        padding: EdgeInsets.all(DeviceInfo.height / 100),
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
                ? SizedBox(height: DeviceInfo.height / 60)
                : const SizedBox(
                    height: 0,
                  ),
            edit
                ? Row(
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: DeviceInfo.height / 20,
                          child: TextField(
                            onSubmitted: (value) {
                              changeUsername();
                            },
                            keyboardAppearance:
                                DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
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
                        height: DeviceInfo.height / 20,
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
    final Map map = await APIUsers().httpPatchAccount(username: newUsername.input.text);
    if (map["success"] == true) {
      setState(() {
        newUsername.input.clear();
        newUsername.hint = language["Username changed successfully"];
        newUsername.color = Colors.green;
        newUsername.error = false;
        newUsername.changed = true;
      });
      widget.refresh();
    } else if (map["message"] == "Invalid Username") {
      setState(() {
        newUsername.input.clear();
        newUsername.hint = language["Username is not valid"];
        newUsername.color = Colors.red;
        newUsername.error = true;
        newUsername.changed = false;
      });
    } else if (map["message"] == "Username is taken") {
      setState(() {
        newUsername.input.clear();
        newUsername.hint = language["Username is taken"];
        newUsername.color = Colors.red;
        newUsername.error = true;
        newUsername.changed = false;
      });
    }
  }
}
