import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/subviews/app_bar/title.dart';
import 'package:freequiz/_views/subviews/buttons/submit.dart';
import 'package:freequiz/_views/subviews/textfields/password.dart';
import 'package:freequiz/_views/subviews/textfields/username.dart';
import 'package:freequiz/loading/error_loading/alert.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/_views/profile/profile.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  final Function refresh;
  const Login({super.key, required this.refresh});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextFieldData username = TextFieldData(hint: 'username'.tr());
  final password = TextFieldData(hint: 'password'.tr(), shown: false);
  bool pressed = false;

  late Map mapLogin;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle()),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: context.mobileLayout
              ? const EdgeInsets.all(10.0)
              : EdgeInsets.symmetric(horizontal: context.screenWidth / 5.5, vertical: 10.0),
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: context.screenHeight / 60),
                Text(
                  context.tr('login'),
                  style: fontSize(FontSize.headline),
                ),
                SizedBox(height: context.screenHeight / 60),
                UsernameTextfield(
                  username: username,
                  focusNode: focusNode,
                  autofillHints: const [AutofillHints.username],
                ),
                const SizedBox(height: 5),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: PasswordTextfield(
                          password: password,
                          focusNode: focusNode,
                          onSubmitted: () => onPressed(widget.refresh),
                          autofillHints: const [AutofillHints.password],
                        ),
                      ),
                      Space.width(5),
                      SubmitButton(pressed: pressed, onPressed: () => onPressed(widget.refresh))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => resetPassword(),
                  child: Text(context.tr('reset password')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetPassword() async {
    final Uri url = Uri.parse('https://www.freequiz.ch/password/reset');
    if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
    }
  }

  onPressed(Function refresh) async {
    if (password.input.text.isEmpty) {
      setState(() {
        password.error = true;
        password.color = Colors.red;
        password.hint = context.tr('wrong password');
        pressed = false;
        FocusScope.of(context).requestFocus(FocusNode());
      });
    } else if (username.input.text.isEmpty) {
      setState(() {
        username.error = true;
        username.color = Colors.red;
        username.hint = context.tr('username error');
        pressed = false;
        FocusScope.of(context).requestFocus(FocusNode());
      });
    } else {
      setState(() {
        pressed = true;
      });
      mapLogin = await APIUsers.login(username.input.text.trim(), password.input.text.trim());
      if (mapLogin.isNotEmpty) {
        if (mapLogin['success']) {
          Profile.accessToken = mapLogin["access_token"];
          Profile.saveAccessToken();
          if (mounted) Navigator.of(context).pop();
          widget.refresh();
          return;
        }
        if (mapLogin["message"] == "User doesn't exist") {
          setState(() {
            username.error = true;
            username.color = Colors.red;
            username.hint = context.tr('username error');
            pressed = false;
            username.input.clear();
            FocusScope.of(context).requestFocus(FocusNode());
          });
        } else if (mapLogin["message"] == "Wrong password") {
          setState(() {
            password.error = true;
            password.color = Colors.red;
            password.hint = context.tr('wrong password');
            pressed = false;
            password.input.clear();
            FocusScope.of(context).requestFocus(FocusNode());
          });
        } else if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) => ErrorLoadingAlert(
              previousWidget: Login(refresh: refresh),
              error: mapLogin["error"] ?? mapLogin["token"] ?? "other error",
              argument: mapLogin["reason"] != null ? [mapLogin["reason"]] : null,
            ),
          );
        }
      }
    }
  }
}
