import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/subviews/app_bar/title.dart';
import 'package:freequiz/_views/subviews/buttons/submit.dart';
import 'package:freequiz/_views/subviews/textfields/password.dart';
import 'package:freequiz/_views/subviews/textfields/username.dart';
import 'package:freequiz/controllers/profile/login.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function refresh;
  const Login({super.key, required this.refresh});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);

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
                  username: controller.username,
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
                          password: controller.password,
                          focusNode: focusNode,
                          onSubmitted: () => controller.login(context, widget.refresh),
                          autofillHints: const [AutofillHints.password],
                        ),
                      ),
                      Space.width(5),
                      SubmitButton(pressed: controller.pressed, onPressed: () => controller.login(context, widget.refresh))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => controller.resetPassword(),
                  child: Text(context.tr('reset password')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
