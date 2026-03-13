import 'package:freequiz/_views/profile/profile_info/profile_info.dart';
import 'package:freequiz/controllers/profile/profile_info.dart';
import 'package:freequiz/loading/error_loading/view.dart';
import 'package:freequiz/loading/loading_screen/animation.dart';
import 'package:freequiz/controllers/user/manage.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:provider/provider.dart';

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
                widget: ChangeNotifierProvider(
                  create: (_) => ProfileInfoController(),
                  child: ProfileInfo(refresh: refresh),
                ),
              );
            }
            return Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => ErrorLoadingView(
                  error: data.data!["message"],
                  widget: ProfilePage(refresh: refresh),
                  appBar: false,
                ),
              ),
            );
          } else if (data.hasError) {
            return Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => ErrorLoadingView(
                  error: data.data!["message"],
                  widget: ProfilePage(refresh: refresh),
                  appBar: false,
                ),
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
