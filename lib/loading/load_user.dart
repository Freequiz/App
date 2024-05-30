import 'package:flutter/material.dart';
import 'package:freequiz/_home/user_page/list_quizzes.dart';
import 'package:freequiz/_home/user_page/user_page.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/loading/loading.dart';
import 'package:freequiz/loading/loading_screen/view.dart';

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
                title: Text(user),
              ),
            ),
          context: context,
          onLoad: () => ListPublicQuizzes.data.addAll(data.data!['data'],)
        );
      },
    );
  }
}
