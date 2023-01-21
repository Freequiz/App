import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/created_quizzes/list_quizzes.dart';
import 'package:freequiz/1_edit/edit_overview.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/others/loading/error_loading/error_loading2.dart';
import 'package:freequiz/others/loading/loading_screen/loading_screen2.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  refresh() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Map>(
        future: APIUsers().httpGetCreatedQuizzes(1),
        builder: (context, data) {
          if (data.hasData) {
            if (data.data!["success"]) {
              ListQuizzes.data = data.data!['data'];
              return LoadingScreen2(
                message: "Loading Quizzes",
                finishedLoading: true,
                widget: EditOverview(
                  data: data.data!['data'],
                  refresh: refresh,
                ),
              );
            }
            return Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => ErrorLoading2(
                    error: data.data!["message"],
                    previousWidget: const EditPage()),
              ),
            );
          } else if (data.hasError) {
            return Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => ErrorLoading2(
                    error: data.data!["message"],
                    previousWidget: const EditPage()),
              ),
            );
          }
          return const LoadingScreen2(
            message: "Loading Quizzes",
          );
        },
      ),
    );
  }
}
