import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/quiz_tile.dart';
import 'package:freequiz/_home/user_page/list_quizzes.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/string_extensions.dart';
import 'package:freequiz/others/style.dart';

class PublicQuizzes extends StatefulWidget {
  final String user;
  const PublicQuizzes({super.key, required this.user});

  @override
  State<PublicQuizzes> createState() => _PublicQuizzesState();
}

class _PublicQuizzesState extends State<PublicQuizzes> {
  bool pressed = false;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Quizzes".transl(),
            style: TextStyle(fontSize: DeviceInfo().height() / 30),
          ),
        ),
        SizedBox(
          height: DeviceInfo.mobileLayout ? 10 : 30,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: ListPublicQuizzes.data.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int i) {
            return QuizTile(
              data: ListPublicQuizzes.data[i],
              uuid: ListPublicQuizzes.data[i]['id'],
              expanded: false,
              width: DeviceInfo().width() - 20,
            );
          },
          separatorBuilder: (BuildContext context, int i) {
            return SizedBox(
              height: DeviceInfo.mobileLayout ? 10 : 20,
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
                        color: Colors.white, fontSize: DeviceInfo().height() / 55),
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
    ListPublicQuizzes.data.addAll(
      (await APIUsers().httpGetPublicQuizzes(page, widget.user))['data'],
    );
    setState(() {
      pressed = false;
    });
  }
}
