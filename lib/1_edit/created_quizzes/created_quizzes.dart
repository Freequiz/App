import 'package:freequiz/_views/buttons/load_more.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/quiz_tile/edit_quiz.dart';
import 'package:freequiz/1_edit/created_quizzes/list_quizzes.dart';
import 'package:freequiz/api/users.dart';

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
            style: titleStyle(),
          ),
        ),
        SizedBox(
          height: context.mobileLayout ? 5 : 15,
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
            return const SizedBox(height: 10);
          },
        ),
        SizedBox(
          height: context.mobileLayout ? 10 : 15,
        ),
        LoadMoreButton(pressed: pressed, onPressed: onPressed, more: ListQuizzes.more),
      ],
    );
  }

  onPressed() async {
    setState(() {
      pressed = true;
    });

    page++;
    final data = await APIUsers.getQuizzes(page);
    ListQuizzes.data.addAll(data['data']);
    ListQuizzes.more = data['next_page'];

    setState(() {
      pressed = false;
    });
  }
}
