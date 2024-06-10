import 'package:flutter/material.dart';
import 'package:freequiz/_views/quiz_tile/dismissible.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';

class ListQuizzes extends StatefulWidget {
  final ScrollPhysics physics;
  final int n;
  final List data;
  final Function onDismissed;
  final Widget background;
  const ListQuizzes(
      {super.key,
      required this.data,
      required this.onDismissed,
      this.physics = const AlwaysScrollableScrollPhysics(),
      required this.background,
      this.n = 0});

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
      itemCount: context.mobileLayout ? data.length : half(data.length),
      itemBuilder: (BuildContext context, int i) {
        final quizData = data[context.mobileLayout ? i : i * 2 + widget.n];
        return DismissibleQuizTile(
          quizData: quizData,
          background: widget.background,
          onDismissed: (uuid) => onDismissed(i, uuid),
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return SizedBox(
          height: context.mobileLayout ? 10 : 30,
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
