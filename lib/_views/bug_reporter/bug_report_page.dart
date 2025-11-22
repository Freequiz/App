import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/services/api/bug_reports.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class BugReportPage extends StatefulWidget {
  const BugReportPage({super.key});

  @override
  State<BugReportPage> createState() => _BugReportPageState();
}

class _BugReportPageState extends State<BugReportPage> {
  TextFieldData title = TextFieldData(hint: 'title'.tr());
  TextFieldData description = TextFieldData(hint: 'description'.tr());
  TextFieldData platform = TextFieldData(hint: 'platform'.tr());

  Color buttonColor = grayFreequiz;

  @override
  Widget build(BuildContext context) {
    final hintColor = context.darkMode ? Colors.white : gray40;

    return Padding(
      padding: context.mobileLayout
          ? const EdgeInsets.all(10.0)
          : EdgeInsets.symmetric(horizontal: context.screenWidth / 5.5, vertical: 10.0),
      child: Column(
        children: [
          Text(
            context.tr('bug reporter'),
            style: const TextStyle(fontSize: FontSize.headline, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.screenHeight / 100),
              color: context.darkMode ? gray55 : blueLight,
            ),
            child: Padding(
              padding: EdgeInsets.all(context.screenHeight / 100),
              child: Column(
                children: [
                  TextField(
                    onSubmitted: (value) => FocusScope.of(context).nextFocus(),
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
                      fillColor: context.darkMode
                          ? const Color.fromARGB(255, 45, 45, 45)
                          : const Color.fromARGB(255, 234, 247, 255),
                      contentPadding: const EdgeInsets.all(10.0),
                      hintStyle: TextStyle(
                        color: title.error ? Colors.red : hintColor,
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: title.error ? context.tr('title error') : title.hint,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: title.error ? Colors.red : (context.darkMode ? beigeMedium : grayFreequiz),
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Space.height(5),
                  TextField(
                    onSubmitted: (value) => FocusScope.of(context).nextFocus(),
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
                      fillColor: context.darkMode
                          ? const Color.fromARGB(255, 45, 45, 45)
                          : const Color.fromARGB(255, 234, 247, 255),
                      contentPadding: const EdgeInsets.all(10.0),
                      hintText: description.error ? context.tr('description error') : description.hint,
                      hintStyle: TextStyle(
                        color: description.error ? Colors.red : hintColor,
                      ),
                    ),
                  ),
                  Space.height(5),
                  TextField(
                    onSubmitted: (value) => FocusScope.of(context).nextFocus(),
                    onEditingComplete: () {},
                    controller: platform.input,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: context.darkMode
                          ? const Color.fromARGB(255, 45, 45, 45)
                          : const Color.fromARGB(255, 234, 247, 255),
                      contentPadding: const EdgeInsets.all(10.0),
                      hintText: platform.hint,
                      hintStyle: TextStyle(
                        color: hintColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Space.height(context.screenHeight / 40),
          Align(
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: buttonColor, foregroundColor: Colors.white),
              onPressed: () {
                submit();
              },
              child: Text(
                context.tr('submit'),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submit() async {
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
      setState(() {
        title.input.clear();
        description.input.clear();
        platform.input.clear();
        buttonColor = Colors.green;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() => buttonColor = grayFreequiz);
      });
    }
  }
}
