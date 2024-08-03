import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/created_quizzes/list_quizzes.dart';
import 'package:freequiz/1_edit/edit_overview.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/loading/error_loading/alert.dart';
import 'package:freequiz/loading/loading_screen/animation.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Map>(
        future: APIUsers.getQuizzesAndDraft(1),
        builder: (context, data) {
          if (data.hasData) {
            if (data.data!["success"]) {
              ListQuizzes.data = data.data!['data'];
              return LoadingAnimation(
                message: "Loading Quizzes",
                finishedLoading: true,
                widget: EditOverview(
                  data: data.data!['data'],
                ),
              );
            }
            return Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => ErrorLoadingAlert(
                    error: data.data?["message"] ?? data.data!["token"] ,
                    previousWidget: const EditPage(),
                    argument: data.data?["reason"] != null ? [data.data!["reason"]] : null,
                    ),
              ),
            );
          } else if (data.hasError) {
            return Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => ErrorLoadingAlert(
                    error: data.data!["message"],
                    previousWidget: const EditPage()),
              ),
            );
          }
          return const LoadingAnimation(
            message: "Loading Quizzes",
          );
        },
      ),
    );
  }
}
