import 'package:freequiz/_views/quiz_tile/dismissible.dart';
import 'package:freequiz/_views/quiz_tile/quiz_tile.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ListQuizzes extends StatefulWidget {
  final ScrollPhysics physics;
  final int n;
  final List data;
  final Function onDismissed;
  final Widget background;
  final Axis scrollDirection;
  final bool dismissible;
  const ListQuizzes({
    super.key,
    required this.data,
    required this.onDismissed,
    this.physics = const AlwaysScrollableScrollPhysics(),
    required this.background,
    this.n = 0,
    this.scrollDirection = Axis.vertical,
    this.dismissible = true,
  });

  @override
  State<ListQuizzes> createState() => _ListQuizzesState();
}

class _ListQuizzesState extends State<ListQuizzes> {
  get color6 => null;
  List data = [];

  @override
  void initState() {
    data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: widget.physics,
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

  half(int amount) {
    double half = amount / 2;
    if (half.remainder(1) != 0) {
      if (widget.n == 0) {
        return (half + 0.5).toInt();
      }
      return (half - 0.5).toInt();
    }
    return half.toInt();
  }
}
