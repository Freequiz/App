import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/edit/created_quizzes/created_quizzes.dart';
import 'package:freequiz/_views/edit/created_quizzes/list_quizzes.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/utilities/styles/font_style.dart';

class LoadEdit extends StatelessWidget {
  final Key keyChild;
  final Function refresh;
  const LoadEdit({super.key, required this.keyChild, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: APIUsers.getQuizzes(1),
      builder: (context, data) {
        if (data.hasData) {
          if (data.data!["success"]) {
            ListQuizzes.data = data.data!['data'];
            ListQuizzes.more = data.data!['next_page'];
            return CreatedQuizzes(key: keyChild, refresh: refresh);
          }
          return Text(
            context.tr('${data.error ?? data.data?["token"] ?? "other error"}'),
            style: titleStyle(),
          );
        } else if (data.hasError) {
          return Text(
            context.tr('${data.error ?? "other error"}'),
            style: titleStyle(),
          );
        }
        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
