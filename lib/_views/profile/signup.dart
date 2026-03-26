import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/subviews/app_bar/title.dart';
import 'package:freequiz/_views/subviews/buttons/submit.dart';
import 'package:freequiz/_views/subviews/textfields/email.dart';
import 'package:freequiz/_views/subviews/textfields/password.dart';
import 'package:freequiz/_views/subviews/textfields/password_confirmation.dart';
import 'package:freequiz/_views/subviews/textfields/username.dart';
import 'package:freequiz/controllers/profile/signup.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final Function refresh;
  const SignUp({super.key, required this.refresh});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignupController>(context);

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
              : EdgeInsets.symmetric(
                  horizontal: context.screenWidth / 5.5, vertical: 10.0),
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Space.height(context.screenHeight / 60),
                Text(
                  context.tr('sign up'),
                  style: fontSize(FontSize.headline),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.tr('terms 1'),
                      style: fontSize(FontSize.secondary),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => controller.openTerms(),
                      child: Text(
                        context.tr('terms 2'),
                        style: const TextStyle(
                            fontSize: FontSize.secondary, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.screenHeight / 40.0,
                ),
                UsernameTextfield(
                  username: controller.username,
                  focusNode: focusNode,
                  autofillHints: const [AutofillHints.newUsername],
                ),
                const SizedBox(height: 5.0),
                EmailTextfield(email: controller.email, focusNode: focusNode),
                const SizedBox(height: 5.0),
                PasswordTextfield(
                  password: controller.password,
                  focusNode: focusNode,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.newPassword],
                ),
                const SizedBox(height: 5.0),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: PasswordConfirmationTextfield(
                          passwordConfirmation: controller.passwordConfirmation,
                          onSubmitted: () =>
                              controller.onPressed(context, widget.refresh),
                        ),
                      ),
                      const SizedBox(width: 5),
                      SubmitButton(
                        pressed: controller.pressed,
                        onPressed: () =>
                            controller.onPressed(context, widget.refresh),
                      )
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
}
