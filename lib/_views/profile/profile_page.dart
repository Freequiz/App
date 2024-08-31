import 'package:freequiz/_views/profile/profile_info/profile_info.dart';
import 'package:freequiz/loading/error_loading/alert.dart';
import 'package:freequiz/loading/loading_screen/animation.dart';
import 'package:freequiz/controllers/user/manage.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ProfilePage extends StatelessWidget {
  final Function refresh;
  const ProfilePage({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Map>(
        future: ManageUser.load(),
        builder: (context, data) {
          if (data.hasData) {
            if (data.data!["success"]) {
              return LoadingAnimation(
                message: "Loading Profile",
                finishedLoading: true,
                widget: ProfileInfo(refresh: refresh),
              );
            }
            return Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) =>
                    ErrorLoadingAlert(error: data.data!["message"], previousWidget: ProfilePage(refresh: refresh,)),
              ),
            );
          } else if (data.hasError) {
            return Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) =>
                    ErrorLoadingAlert(error: data.data!["message"], previousWidget: ProfilePage(refresh: refresh,)),
              ),
            );
          }
          return const LoadingAnimation(
            message: "Loading Profile",
          );
        },
      ),
    );
  }
}
