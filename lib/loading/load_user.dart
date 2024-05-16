import 'package:flutter/material.dart';
import 'package:freequiz/_home/user_page/list_quizzes.dart';
import 'package:freequiz/_home/user_page/user_page.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/loading/error_loading/error_loading.dart';
import 'package:freequiz/loading/loading_screen/loading_screen.dart';
import 'package:freequiz/others/string_extensions.dart';

loadUser({required BuildContext context, required String user}) {
  ListPublicQuizzes.data.clear();
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
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
                  widget: UserPage(user: user,),
                  appBar: AppBar(
                    title: Text(user),
                  ),
                );
              } else {
                return ErrorLoading(
                  error: data.data!["message"],
                );
              }
            } else if (data.hasError) {
              return const ErrorLoading(
                error: "other error",
              );
            }
            return LoadingScreen(
              message: "Loading User",
              finishedLoading: false,
              appBar: AppBar(
                title: Text("Loading".transl()),
              ),
            );
          },
        );
      },
    ),
  );
}
