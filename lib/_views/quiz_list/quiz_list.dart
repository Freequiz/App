import 'package:freequiz/_views/quiz_list/list.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class QuizList extends StatelessWidget {
  final List list;
  final Function onDismissed;
  final Widget background;
  const QuizList({super.key, required this.list, required this.onDismissed, required this.background});

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      mobile: ListQuizzes(
        data: list,
        background: background,
        onDismissed: onDismissed,
      ),
      tablet: ListQuizzes(
        data: list,
        background: background,
        onDismissed: onDismissed,
        scrollDirection: Axis.horizontal,
        dismissible: false,
      ),
    );
  }
}
