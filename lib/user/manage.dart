import 'package:freequiz/api/api.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/local_storage/preferences.dart';
import 'package:freequiz/models/user.dart';
import 'package:freequiz/user/helper.dart';

class ManageUser {
  static Future<Map> load() async {
    if (UserHelper.user != null) {
      if (UserHelper.user!.username != "") {
        return {'success': true, 'data': UserHelper.user!.toMap()};
      }
    }

    final futureUser = APIUsers.getData();

    final localUser = await Preferences.loadUser();
    UserHelper.user = User.fromJson(localUser);

    final user = await futureUser;

    if (user['success']) {
      UserHelper.user = User.fromJson(user['data']);
      Preferences.saveUser();

      return user;
    }

    if (user.containsKey('message')) {
      if (user['message'] == Api.noConnection || user['message'] == Api.timeout) {
        UserHelper.user = User.fromJson(localUser);

        user['data'] = localUser;
        user['offline_data'] = true;
        return user;
      }
    }

    return user;
  }
}