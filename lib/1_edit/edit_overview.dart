import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_create_quiz/create_quiz.dart';
import 'package:freequiz/1_edit/created_quizzes/created_quizzes.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class EditOverview extends StatefulWidget {
  final List data;
  final Function refresh;
  const EditOverview({super.key, required this.data, required this.refresh});

  @override
  State<EditOverview> createState() => _EditOverviewState();
}

class _EditOverviewState extends State<EditOverview> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: color1, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CreateQuiz(refresh: widget.refresh,);
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  language["Create a New Quiz"],
                  style: TextStyle(fontSize: height / 45),
                ),
              ),
            ),
          ),
          SizedBox(
            height: mobileLayout ? 15 : 45,
          ),
          Expanded(
            child: CreatedQuizzes(data: widget.data),
          ),
        ],
      ),
    );
  }
}
