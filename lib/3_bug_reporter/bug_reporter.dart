import 'package:flutter/material.dart';
import 'package:freequiz/api/bug_reports.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/textfield_data.dart';
import 'package:device_info_plus/device_info_plus.dart';

class BugReporter extends StatefulWidget {
  const BugReporter({super.key});

  @override
  State<BugReporter> createState() => _BugReporterState();
}

class _BugReporterState extends State<BugReporter> {
  TextFieldData title = TextFieldData(hint: language["Title"]);
  TextFieldData description = TextFieldData(hint: language["Description"]);
  TextFieldData platform = TextFieldData(hint: language["Platform"]);

  @override
  Widget build(BuildContext context) {
    final hintColor =
        DeviceInfo.darkMode ? Colors.white : const Color.fromARGB(255, 40, 40, 40);
    return Scaffold(
      appBar: AppBar(
        title: Text(language["Bug Reporter"]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
                color:
                    DeviceInfo.darkMode ? const Color.fromARGB(255, 55, 55, 55) : color4,
              ),
              child: Padding(
                padding: EdgeInsets.all(DeviceInfo().height() / 100),
                child: Column(
                  children: [
                    TextField(
                      onSubmitted: (value) {
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (value) {
                        setState(() {
                          title.error = false;
                        });
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {},
                      controller: title.input,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: DeviceInfo.darkMode
                            ? const Color.fromARGB(255, 45, 45, 45)
                            : const Color.fromARGB(255, 234, 247, 255),
                        contentPadding: const EdgeInsets.all(10.0),
                        hintStyle: TextStyle(
                          color: title.error ? Colors.red : hintColor,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: title.error
                            ? language["Title at least 3 characters"]
                            : title.hint,
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: title.error
                                ? Colors.red
                                : (DeviceInfo.darkMode ? color3 : color1),
                            width: 3.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      onSubmitted: (value) {
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (value) {
                        setState(() {
                          description.error = false;
                        });
                      },
                      textInputAction: TextInputAction.newline,
                      onEditingComplete: () {},
                      controller: description.input,
                      minLines: 6,
                      maxLines: 16,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: DeviceInfo.darkMode
                            ? const Color.fromARGB(255, 45, 45, 45)
                            : const Color.fromARGB(255, 234, 247, 255),
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: description.error
                            ? language["Description at least 10 characters"]
                            : description.hint,
                        hintStyle: TextStyle(
                          color: description.error ? Colors.red : hintColor,
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: description.error ? Colors.red : color1,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      onSubmitted: (value) {
                        FocusScope.of(context).nextFocus();
                      },
                      onEditingComplete: () {},
                      controller: platform.input,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: DeviceInfo.darkMode
                            ? const Color.fromARGB(255, 45, 45, 45)
                            : const Color.fromARGB(255, 234, 247, 255),
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: platform.hint,
                        hintStyle: TextStyle(
                          color: hintColor,
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: color1,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: DeviceInfo().height() / 40,
            ),
            Align(
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: color1, foregroundColor: Colors.white),
                onPressed: () {
                  submit();
                },
                child: Text(
                  language["Submit"],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  submit() async {
    if (title.input.text.length < 3) {
      setState(() {
        title.input.clear();
        title.error = true;
      });
    } else if (description.input.text.length < 10) {
      setState(() {
        description.input.clear();
        description.error = true;
      });
    } else {
      var currentPlatform = Theme.of(context).platform;
      String userAgent = "_Unknown";
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (currentPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        userAgent = iosInfo.toString();
      } else if (currentPlatform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        userAgent = androidInfo.toString();
      }
      httpPutBug(title.input.text, description.input.text, platform.input.text, userAgent);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }
}
