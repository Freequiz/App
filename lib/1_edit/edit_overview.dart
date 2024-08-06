import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/1_edit/quiz_draft/draft.dart';
import 'package:freequiz/1_edit/edit_create_quiz/create_quiz.dart';
import 'package:freequiz/1_edit/created_quizzes/created_quizzes.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
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

  refresh() {
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
            right: context.mobileLayout ? 50.0 :20,
            left: context.mobileLayout ? 50.0 : 20,
            top: 10,
            bottom: 15.0,
          ),
          child: TextButton(
            style: TextButton.styleFrom(backgroundColor: grayFreequiz, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CreateQuiz(
                      refresh: refresh,
                    );
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                context.tr('create new quiz'),
                style: buttonStyle(),
              ),
            ),
          ),
        ),
        Space.height(context.mobileLayout ? 15 : 45),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Conditional(
            condition: QuizHelper.draft.isNotEmpty,
            widget: Draft(
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
