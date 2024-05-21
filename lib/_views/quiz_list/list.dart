import 'package:flutter/material.dart';
import 'package:freequiz/_views/quiz_tile/quiz_tile.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';

class ListQuizzes extends StatefulWidget {
  final ScrollPhysics physics;
  final int n;
  final List data;
  final Function onDismissed;
  const ListQuizzes(
      {super.key,
      required this.data,
      required this.onDismissed,
      this.physics = const ScrollPhysics(),
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
      itemCount: DeviceInfo.mobileLayout
          ? data.length
          : half(data.length),
      itemBuilder: (BuildContext context, int i) {
        final quizData = data[DeviceInfo.mobileLayout ? i : i * 2 + widget.n];
        debugPrint(quizData.toString());
        return Dismissible(
          key: Key(quizData['id']),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) => onDismissed(i),
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(DeviceInfo().height() / 100),
                  bottomRight: Radius.circular(DeviceInfo().height() / 100)),
              color: grayFreequiz,
            ),
            child: const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  Icons.clear_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          child: QuizTile(
            data: quizData,
            uuid: quizData['id'],
            width: DeviceInfo.mobileLayout
                ? DeviceInfo().width() - 20
                : (DeviceInfo().width() - 90) / 2,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return SizedBox(
          height: DeviceInfo.mobileLayout ? 10 : 30,
        );
      },
    );
  }

  onDismissed(i) {
    data.removeAt(i);
    widget.onDismissed(i);
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
