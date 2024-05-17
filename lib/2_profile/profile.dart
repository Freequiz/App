import 'package:freequiz/local_storage/secure_storage.dart';

class Profile {
  static String accessToken = "";
  static bool loaded = false;

  static saveData() async {
    await SecureStorage.setAccessToken(accessToken);
  }

  static loadData() async {
    accessToken = await SecureStorage.readAccessToken();
    loaded = true;
  }

  static deleteData() async {
    await SecureStorage.removeAccessToken();
  }
}