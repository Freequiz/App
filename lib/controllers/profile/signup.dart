import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/controllers/profile/profile.dart';
import 'package:freequiz/controllers/user/manage.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupController extends ChangeNotifier {
  final TextFieldData username = TextFieldData(hint: 'username'.tr());
  final TextFieldData email = TextFieldData(hint: 'email'.tr());
  final TextFieldData password =
      TextFieldData(hint: 'password'.tr(), shown: false);
  final TextFieldData passwordConfirmation =
      TextFieldData(hint: 'confirm password'.tr(), shown: false);

  bool pressed = false;

  void onPressed(BuildContext context, Function refresh) {
    username.unsetError();
    email.unsetError();
    password.unsetError();
    passwordConfirmation.unsetError();

    if (password.input.text != passwordConfirmation.input.text) {
      password.setError('password dont match');
      passwordConfirmation.setError('');
      notifyListeners();
      return;
    }

    if (username.input.text.isEmpty) {
      username.setError('blank');
      notifyListeners();
      return;
    }

    if (email.input.text.isEmpty) {
      email.setError('blank');
      notifyListeners();
      return;
    }

    if (password.input.text.isEmpty) {
      password.setError('blank');
      passwordConfirmation.setError('');
      notifyListeners();
      return;
    }

    signup(context, refresh);
  }

  void signup(BuildContext context, Function refresh) async {
    pressed = true;
    notifyListeners();

    final Map map = await APIUsers.createAccount(
      username.input.text,
      email.input.text,
      password.input.text,
      passwordConfirmation.input.text,
      true,
    );

    if (map["success"] == true) {
      Profile.accessToken = map["access_token"];
      Profile.saveAccessToken();

      if (context.mounted) Navigator.of(context).pop();
      refresh();
      ManageUser.load();

      return;
    }
    if (map["token"] == "password.invalid") {
      password.setError('password length 1');
      passwordConfirmation.setError('password length 2');
      pressed = false;

      notifyListeners();
      return;
    }
    if (map["token"] == "record.invalid") {
      map["errors"].forEach((object, error) {
        String errorMessage = "$object ${error[0]['error']!}";

        switch (object) {
          case "username":
            username.setError(errorMessage);
            pressed = false;
            notifyListeners();
            break;
          case "email":
            email.setError(errorMessage);
            pressed = false;
            notifyListeners();
            break;
          default:
            throw Exception("No matching Error");
        }
      });
    } else {
      throw Exception("Error not handled");
    }
  }

  void openTerms() async {
    final Uri url = Uri.parse('https://www.freequiz.ch/password/reset');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
