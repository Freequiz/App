import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/app_bar/title.dart';
import 'package:freequiz/_views/buttons/submit.dart';
import 'package:freequiz/_views/textfields/password.dart';
import 'package:freequiz/_views/textfields/username.dart';
import 'package:freequiz/loading/error_loading/alert.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

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
                Space.height(context.screenHeight / 60),
                Text(
                  context.tr('login'),
                  style: fontSize(FontSize.headline),
                ),
                Space.height(context.screenHeight / 60),
                UsernameTextfield(
                  username: username,
                  focusNode: focusNode,
                  autofillHints: const [AutofillHints.username],
                ),
                Space.height(5),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  onPressed(Function refresh) async {
    if (password.input.text.isEmpty) {
      setState(() {
        password.error = true;
        password.color = Colors.red;
        password.hint = context.tr('wrong password');
      });
    } else if (username.input.text.isEmpty) {
      setState(() {
        username.error = true;
        username.color = Colors.red;
        username.hint = context.tr('username error');
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
            pressed = false;
            username.input.clear();
          });
        } else if (mapLogin["message"] == "Wrong password") {
          setState(() {
            password.error = true;
            password.color = Colors.red;
            pressed = false;
            password.input.clear();
          });
        } else if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) => ErrorLoadingAlert(
              previousWidget: Login(refresh: refresh),
              error: mapLogin["error"] ?? "other error",
            ),
          );
        }
      }
    }
  }
}
