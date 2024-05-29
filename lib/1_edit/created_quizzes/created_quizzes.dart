import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/quiz_tile/edit_quiz_tile.dart';
import 'package:freequiz/1_edit/created_quizzes/list_quizzes.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/utilities.dart';

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
            context.tr('created quizzes'),
            style: textSize(DeviceInfo().height() / 30),
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
              height: DeviceInfo.mobileLayout ? 10 : 20,
            );
          },
        ),
        SizedBox(
          height: DeviceInfo.mobileLayout ? 5 : 15,
        ),
        conditional(
          pressed,
          Align(
            child: CircularProgressIndicator(
              color: DeviceInfo.darkMode ? Colors.white : grayFreequiz,
            ),
          ),
          defaultWidget: Align(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: grayFreequiz,
                foregroundColor: Colors.white,
              ),
              onPressed: () => onPressed(),
              child: Text(
                context.tr('load more'),
                style: TextStyle(
                    color: Colors.white, fontSize: DeviceInfo().height() / 55),
              ),
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
      (await APIUsers.getQuizzes(page))['data'],
    );

    setState(() {
      pressed = false;
    });
  }
}
