import 'package:flutter/material.dart';
import 'package:freequiz/_views/edit/quiz_draft/draft.dart';
import 'package:freequiz/services/api/users.dart';

class LoadDraft extends StatelessWidget {
  final Function refresh;
  const LoadDraft({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: APIUsers.getDraft(),
      builder: (context, data) {
        if (data.hasData) {
          if (data.data!["success"]) {
            return Draft(refresh: refresh);
          }
        }
        return SizedBox();
      },
    );
  }
}
