import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/controllers/profile/user.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/utilities/imports/base.dart';

class ProfilePageController extends ChangeNotifier {
  TextFieldData newUsername = TextFieldData(hint: 'username'.tr());
  bool editUsername = false;
  bool pressedUsername = false;

  TextFieldData newEmail = TextFieldData(hint: 'email'.tr());
  bool editEmail = false;
  bool pressedEmail = false;

  TextFieldData newPassword =
      TextFieldData(hint: 'password'.tr(), shown: false);
  TextFieldData newPasswordConfirmation =
      TextFieldData(hint: 'confirm password'.tr(), shown: false);
  TextFieldData oldPassword =
      TextFieldData(hint: 'old password'.tr(), shown: false);
  bool editPassword = false;
  bool pressedPassword = false;

  void toggleEditUsername() {
    editUsername = !editUsername;
    notifyListeners();
  }

  void toggleEditEmail() {
    editEmail = !editEmail;
    notifyListeners();
  }

  void toggleEditPassword() {
    editPassword = !editPassword;
    notifyListeners();
  }

  IconData icon(bool edit) {  
    if (edit) return Icons.clear;
    return Icons.edit;
  }

  void loadData() async {
    await UserHelper.load(waitForSync: true);
    notifyListeners();
  }

  void changeUsername() async {
    pressedUsername = true;
    notifyListeners();

    final Map map =
        await APIUsers.updateAccount(username: newUsername.input.text);

    if (map["success"] == true) {
      UserHelper.user!.username = newUsername.input.text;
      newUsername.setSuccess('username change');
    } else if (map["errors"]["username"][0]["error"] == "invalid") {
      newUsername.setError('username invalid');
    } else if (map["errors"]["username"][0]["error"] == "taken") {
      newUsername.setError('username taken');
    }

    pressedUsername = false;
    notifyListeners();
  }

  Future<void> changePassword() async {
    pressedPassword = true;
    notifyListeners();

    final Map map = await APIUsers.updateAccount(
      password: newPassword.input.text,
      passwordConfirmation: newPasswordConfirmation.input.text,
      oldPassword: oldPassword.input.text,
    );

    if (map["success"] == true) {
      oldPassword.setSuccess('password change');
      newPassword.setSuccess('successfully');
      newPasswordConfirmation.setSuccess('');
    } else if (map["message"] == "Password doesn't meet requirements") {
      newPassword.setError('password length 1');
      newPasswordConfirmation.setError('password length 2');
    } else if (map["errors"].containsKey("password_challenge")) {
      oldPassword.setError('wrong password');
    } else if (map["errors"].containsKey("password_confirmation")) {
      newPassword.setError('password dont match');
      newPasswordConfirmation.setError('');
    }

    pressedPassword = false;
    notifyListeners();
  }

  void changeEmail() async {
    if (newEmail.input.text.isEmpty) {
      newEmail.setError('blank');
      notifyListeners();
      return;
    }

    pressedEmail = true;
    notifyListeners();

    final Map map = await APIUsers.updateAccount(email: newEmail.input.text);

    if (map["success"] == true) {
      UserHelper.user!.email = newEmail.input.text;
      newEmail.setSuccess('email success');
    } else if (map["token"] == "record.invalid") {
      newEmail.setError('invalid email');
    } else if (map["message"] == "Email is taken") {
      newEmail.setError('email taken');
    }

    pressedEmail = false;
    notifyListeners();
  }
}
