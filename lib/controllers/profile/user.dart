import 'package:freequiz/models/user.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/services/local_storage/preferences.dart';

class UserHelper {
  static User? user;

  static Future<void> load({bool waitForSync = false}) async {
    if (UserHelper.user != null) return;

    final localUser = await Preferences.loadUser();
    UserHelper.user = User.fromJson(localUser);

    if (waitForSync) {
      await sync();
      return;
    } 
    
    sync();
  }

  static Future<void> sync() async {
    final user = await APIUsers.getData();
    
    if (user['success']) {
      UserHelper.user = User.fromJson(user['data']);
      Preferences.saveUser();
    }
  }
}
