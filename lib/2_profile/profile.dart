import 'package:freequiz/local_storage/secure_storage.dart';

class Profile {
  static String accessToken = "";
  static bool loaded = false;

  static saveAccessToken() async {
    await SecureStorage.setAccessToken(accessToken);
  }

  static loadAccessToken() async {
    accessToken = await SecureStorage.readAccessToken();
    loaded = true;
  }

  static deleteData() async {
    accessToken = "";
    await SecureStorage.removeAccessToken();
  }
}