import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/created_quizzes/edit_quiz_tile.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class CreatedQuizzes extends StatefulWidget {
  final List data;
  const CreatedQuizzes({super.key, required this.data});

  @override
  State<CreatedQuizzes> createState() => _CreatedQuizzesState();
}

class _CreatedQuizzesState extends State<CreatedQuizzes> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            language["Created Quizzes"],
            style: TextStyle(fontSize: DeviceInfo.height / 30),
          ),
        ),
        SizedBox(
          height: DeviceInfo.mobileLayout ? 5 : 15,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: widget.data.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int i) {
            return EditQuizTile(
              data: widget.data[i],
              uuid: widget.data[i]['id'],
              expanded: false,
            );
          },
          separatorBuilder: (BuildContext context, int i) {
            return SizedBox(
              height: DeviceInfo.mobileLayout ? 10 : 30,
            );
          },
        ),
        SizedBox(
          height: DeviceInfo.mobileLayout ? 5 : 15,
        ),
        Align(
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: color1,
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: Text(
              language["Load more"],
              style: TextStyle(color: Colors.white, fontSize: DeviceInfo.height / 55),
            ),
          ),
        ),
      ],
    );
  }
}
