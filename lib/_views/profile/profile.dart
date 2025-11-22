import 'package:freequiz/services/local_storage/preferences.dart';
import 'package:freequiz/services/local_storage/secure_storage.dart';
import 'package:freequiz/controllers/user/helper.dart';

class Profile {
  static String accessToken = "";
  static bool loaded = false;

  static void saveAccessToken() async {
    await SecureStorage.setAccessToken(accessToken);
  }

  static Future<void> loadAccessToken() async {
    accessToken = await SecureStorage.readAccessToken();
    loaded = true;
  }

  static void deleteData() async {
    accessToken = "";
    UserHelper.user = null;
    Preferences.deleteUser();
    SecureStorage.removeAccessToken();
  }
}