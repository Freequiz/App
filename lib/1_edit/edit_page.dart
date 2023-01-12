import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/create_quiz/create_quiz.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
        height: height / 6,
        width: width / 1.5,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: color1, foregroundColor: Colors.white),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const CreateQuiz();
                },
              ),
            );
          },
          child: Text(language["Create a New Quiz"], style: TextStyle(fontSize: height / 40),),
        ),
      ),
    );
  }
}
