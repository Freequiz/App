import 'dart:math';

import 'package:freequiz/_views/edit/buttons/create.dart';
import 'package:freequiz/_views/edit/buttons/import.dart';
import 'package:freequiz/_views/edit/buttons/scan.dart';
import 'package:freequiz/_views/edit/quiz_draft/draft.dart';
import 'package:freequiz/_views/edit/created_quizzes/created_quizzes.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class EditOverview extends StatefulWidget {
  final List data;
  const EditOverview({super.key, required this.data});

  @override
  State<EditOverview> createState() => _EditOverviewState();
}

class _EditOverviewState extends State<EditOverview> {
  bool draft = false;
  Key key = Key(Random().toString());

  void refresh() {
    setState(() {
      key = Key(Random().toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: context.darkMode ? darkMainColor : lightMainColor,
          width: double.maxFinite,
          padding: EdgeInsets.only(
            right: context.mobileLayout ? 0.0 : 20,
            left: context.mobileLayout ? 0.0 : 20,
            top: 10,
            bottom: 15.0,
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CreateButton(refresh: refresh),
                const SizedBox(width: 10),
                ImportButton(refresh: refresh),
                const SizedBox(width: 10),
                ScanButton(refresh: refresh),
              ],
            ),
          )
        ),
        Space.height(context.mobileLayout ? 15 : 45),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Visibility(
            visible: QuizHelper.draft.isNotEmpty,
            child: Draft(
              refresh: refresh,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CreatedQuizzes(
              key: key,
              refresh: refresh,
            ),
          ),
        ),
      ],
    );
  }
}
