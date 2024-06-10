import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/quiz_tile/quiz_tile.dart';
import 'package:freequiz/_home/user_page/list_quizzes.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';
import 'package:freequiz/utilities/widgets/conditional.dart';
import 'package:freequiz/utilities/widgets/space.dart';

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
            context.tr('quizzes'),
            style: TextStyle(fontSize: context.screenHeight/ 30),
          ),
        ),
        Space.height(context.mobileLayout ? 10 : 30),
        ListView.separated(
          shrinkWrap: true,
          itemCount: ListPublicQuizzes.data.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int i) {
            return QuizTile(
              data: ListPublicQuizzes.data[i],
              uuid: ListPublicQuizzes.data[i]['id'],
              expanded: false,
              width: context.screenWidth - 20,
            );
          },
          separatorBuilder: (BuildContext context, int i) {
            return Space.height(context.mobileLayout ? 10 : 20);
          },
        ),
        Space.height(context.mobileLayout ? 5 : 15),
        Conditional(
          condition: pressed,
          widget: Align(
            child: CircularProgressIndicator(
              color: context.darkMode ? Colors.white : grayFreequiz,
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
                    color: Colors.white, fontSize: context.screenHeight/ 55),
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
    ListPublicQuizzes.data.addAll(
      (await APIUsers.getPublicQuizzes(page, widget.user))['data'],
    );
    setState(() {
      pressed = false;
    });
  }
}
