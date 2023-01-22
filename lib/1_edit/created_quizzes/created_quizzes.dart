import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/created_quizzes/edit_quiz_tile.dart';
import 'package:freequiz/1_edit/created_quizzes/list_quizzes.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class CreatedQuizzes extends StatefulWidget {
  final Function refresh;
  const CreatedQuizzes({super.key, required this.refresh});

  @override
  State<CreatedQuizzes> createState() => _CreatedQuizzesState();
}

class _CreatedQuizzesState extends State<CreatedQuizzes> {
  bool pressed = false;
  int page = 1;

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
          itemCount: ListQuizzes.data.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int i) {
            return EditQuizTile(
              data: ListQuizzes.data[i],
              uuid: ListQuizzes.data[i]['id'],
              expanded: false,
              refresh: widget.refresh,
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
        pressed
            ? Align(
                child: CircularProgressIndicator(
                  color: DeviceInfo.darkMode ? Colors.white : color1,
                ),
              )
            : Align(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: color1,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => onPressed(),
                  child: Text(
                    language["Load more"],
                    style: TextStyle(
                        color: Colors.white, fontSize: DeviceInfo.height / 55),
                  ),
                ),
              ),
      ],
    );
  }

  onPressed() async {
    setState(() {
      pressed = true;
    });
    page++;
    ListQuizzes.data.addAll(
      (await APIUsers().httpGetCreatedQuizzes(page))['data'],
    );
    setState(() {
      pressed = false;
    });
  }
}
