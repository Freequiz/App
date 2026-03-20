import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/profile/login.dart';
import 'package:freequiz/controllers/profile/profile.dart';
import 'package:freequiz/controllers/profile/user.dart';
import 'package:freequiz/loading/error_loading/alert.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends ChangeNotifier {
  final password = TextFieldData(hint: 'password'.tr(), shown: false);
  final username = TextFieldData(hint: 'username'.tr());

  bool pressed = false;

  late Map mapLogin;

  void resetPassword() async {
    final Uri url = Uri.parse('https://www.freequiz.ch/password/reset');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void login(BuildContext context, Function refresh) async {
    username.unsetError();
    password.unsetError();

    pressed = true;
    notifyListeners();

    mapLogin = await APIUsers.login(
      username.input.text.trim(),
      password.input.text.trim(),
    );

    if (mapLogin.isNotEmpty) {
      if (mapLogin['success']) {
        Profile.accessToken = mapLogin["access_token"];
        Profile.saveAccessToken();

        UserHelper.sync();

        if (context.mounted) Navigator.of(context).pop();
        refresh();

        return;
      }

      if (!context.mounted) return;

      if (mapLogin["message"] == "User doesn't exist") {
        username.setError('username error');
        pressed = false;

        FocusScope.of(context).requestFocus(FocusNode());
        notifyListeners();
        return;
      }
      if (mapLogin["message"] == "Wrong password") {
        password.setError('wrong password');
        pressed = false;

        FocusScope.of(context).requestFocus(FocusNode());
        notifyListeners();
        return;
      }
    } else if (context.mounted) {
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
