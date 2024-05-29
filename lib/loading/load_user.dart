import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_home/user_page/list_quizzes.dart';
import 'package:freequiz/_home/user_page/user_page.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/loading/error_loading/view.dart';
import 'package:freequiz/loading/loading_screen/loading_screen.dart';

loadUser({required BuildContext context, required String user}) {
  ListPublicQuizzes.data.clear();

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
        if (data.hasData) {
          if (data.data!['success']) {
            ListPublicQuizzes.data.addAll(
              data.data!['data'],
            );
            return LoadingScreen(
              message: "Loading User",
              finishedLoading: true,
              widget: UserPage(
                user: user,
              ),
              appBar: AppBar(
                title: Text(user),
              ),
            );
          } else {
            return ErrorLoadingView(
              error: data.data!["message"],
              widget: this,
            );
          }
        } else if (data.hasError) {
          return ErrorLoadingView(
            error: "other error",
            widget: this,
          );
        }
        return LoadingScreen(
          message: "Loading User",
          finishedLoading: false,
          appBar: AppBar(
            title: const Text('loading').tr(),
          ),
        );
      },
    );
  }
}
