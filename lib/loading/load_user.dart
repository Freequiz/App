import 'package:flutter/material.dart';
import 'package:freequiz/_views/_home/user_page/user_data.dart';
import 'package:freequiz/_views/_home/user_page/user_page.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/loading/loading.dart';
import 'package:freequiz/loading/loading_screen/view.dart';
import 'package:share_plus/share_plus.dart';

void loadUser({required BuildContext context, required String user}) {
  PublicUserData.data.clear();

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return LoadUser(user: user);
      },
    ),
  );
}

class LoadUser extends StatelessWidget {
  final String user;

  const LoadUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: APIUsers.getPublicQuizzes(1, user),
      builder: (context, data) {
        return loading(
          data: data,
          previousWidget: this,
          widget: LoadingScreen(
            message: "Loading User",
            finishedLoading: true,
            widget: UserPage(
              user: user,
            ),
            appBar: AppBar(
              actions: [
                TextButton(
                  onPressed: () => SharePlus.instance.share(
                    ShareParams(text: 'https://www.freequiz.ch/user/$user'),
                  ),
                  child: const Icon(
                    Icons.ios_share_rounded,
                  ),
                ),
              ],
            ),
          ),
          context: context,
          onLoad: () {
            PublicUserData.data.addAll(data.data!['data']);
            PublicUserData.more = data.data!['next_page'];
            PublicUserData.avatarURL = data.data!['avatar_url'];
            PublicUserData.name = user;
          },
        );
      },
    );
  }
}
