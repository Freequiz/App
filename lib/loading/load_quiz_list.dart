import 'package:flutter/material.dart';
import 'package:freequiz/_views/quiz_list/quiz_list.dart';
import 'package:freequiz/api/api.dart';
import 'package:freequiz/loading/no_connection/no_connection.dart';
import 'package:freequiz/others/style.dart';

class LoadQuizList extends StatelessWidget {
  final Future<Map> future;
  final Function onDismissed;
  final Widget background;
  const LoadQuizList({super.key, required this.future, required this.onDismissed, required this.background});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: future,
      builder: (context, data) {
        if (data.hasData) {
          if (data.data!['success']) {
            final List list = data.data!['data'] as List;

            return QuizList(list: list, onDismissed: onDismissed, background: background,);
          }
          if (data.data!['message'] == Api.noConnection || data.data!['message'] == Api.timeout) {
            if (data.data!.containsKey('offline_data')) {
              final List list = data.data!['data'] as List;

              return QuizList(list: list, onDismissed: onDismissed, background: background,);
            }
            return const NoConnectionAlert(backgroundColor: gray55, showButton: false,);
          }
          return Drawer(child: Text('${data.error}'));
        }
        if (data.hasError) {
          return Drawer(child: Text('${data.error}'));
        }
        return const SizedBox();
      },
    );
  }
}
