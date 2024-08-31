import 'package:freequiz/_views/subviews/quiz_list/placeholder.dart';
import 'package:freequiz/_views/subviews/quiz_tile/dismissible.dart';
import 'package:freequiz/_views/subviews/quiz_tile/quiz_tile.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ListQuizzes extends StatefulWidget {
  final List data;
  final Function onDismissed;
  final Widget background;
  final Axis scrollDirection;
  final bool dismissible;
  const ListQuizzes({
    super.key,
    required this.data,
    required this.onDismissed,
    required this.background,
    this.scrollDirection = Axis.vertical,
    this.dismissible = true,
  });

  @override
  State<ListQuizzes> createState() => _ListQuizzesState();
}

class _ListQuizzesState extends State<ListQuizzes> {
  List data = [];

  @override
  void initState() {
    data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const QuizListPlaceholder();

    return ListView.separated(
      itemCount: data.length,
      scrollDirection: widget.scrollDirection,
      itemBuilder: (BuildContext context, int i) {
        if (widget.dismissible) {
          return DismissibleQuizTile(
            quizData: data[i],
            background: widget.background,
            onDismissed: (uuid) => onDismissed(i, uuid),
          );
        }
        return Align(
          alignment: Alignment.topCenter,
          child: QuizTile(
            data: data[i],
            uuid: data[i]['id'],
            width: 400,
            height: 152,
            onDismissed: (uuid) => onDismissed(i, uuid),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return const LayoutWidget(
          mobile: SizedBox(
            height: 10,
          ),
          tablet: SizedBox(
            width: 15.0,
          ),
        );
      },
    );
  }

  onDismissed(int i, String uuid) {
    setState(() {
      data.removeAt(i);
    });
    widget.onDismissed(i, uuid);
  }
}
