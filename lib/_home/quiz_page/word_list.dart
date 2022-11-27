import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz.dart';

class WordList extends StatefulWidget {
  final List definitions;
  final List answers;
  final List marked;
  final Function markWord;
  final int i;
  final Color color;
  final ScrollPhysics scrollPhysics;
  final double width;
  final bool roundedCornersTop;
  const WordList({
    super.key,
    required this.definitions,
    required this.answers,
    this.marked = const [],
    required this.markWord,
    this.i = 0,
    required this.color,
    this.scrollPhysics = const ScrollPhysics(),
    required this.width,
    this.roundedCornersTop = true,
  });

  @override
  State<WordList> createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    final color5 = darkMode
        ? const Color.fromARGB(255, 60, 60, 60)
        : const Color.fromARGB(255, 225, 225, 225);
    final color6 = darkMode
        ? const Color.fromARGB(255, 50, 50, 50)
        : const Color.fromARGB(255, 245, 245, 245);
    return ListView.builder(
      shrinkWrap: true,
      physics: widget.scrollPhysics,
      itemCount: widget.definitions.length,
      itemBuilder: (BuildContext context, int i) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: i == 0 && widget.roundedCornersTop
                    ? Radius.circular(widget.width / 30.4)
                    : Radius.zero,
                topRight: i == 0 && widget.roundedCornersTop
                    ? Radius.circular(widget.width / 30.4)
                    : Radius.zero,
                bottomLeft: i == widget.definitions.length - 1
                    ? Radius.circular(widget.width / 30.4)
                    : Radius.zero,
                bottomRight: i == widget.definitions.length - 1
                    ? Radius.circular(widget.width / 30.4)
                    : Radius.zero),
            color: i.remainder(2) == 0 ? color5 : color6,
          ),
          child: Padding(
            padding: EdgeInsets.all(mobileLayout ? 0 : height / 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 5.0),
                Container(
                  width: mobileLayout
                      ? (widget.width - 30) / 2 - height / 30
                      : (widget.width - 30) / 2 - height / 20 - height / 80,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      widget.definitions[i],
                      style: TextStyle(
                          fontSize: mobileLayout ? height / 50 : height / 45),
                    ),
                  ),
                ),
                Container(
                  width: mobileLayout
                      ? (widget.width - 30) / 2 - height / 30
                      : (widget.width - 30) / 2 - height / 20 - height / 80,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      widget.answers[i],
                      style: TextStyle(
                          fontSize: mobileLayout ? height / 50 : height / 45),
                    ),
                  ),
                ),
                SizedBox(
                  width: height / 20,
                  child: TextButton(
                    onPressed: () {
                      widget.markWord(widget.i, i);
                    },
                    child: Quiz.markedWords[
                            widget.marked.isEmpty ? i : widget.marked[i]]
                        ? Icon(
                            Icons.star,
                            color: widget.color,
                            size: mobileLayout ? height / 50 : height / 45,
                          )
                        : Icon(
                            Icons.star_border,
                            color: widget.color,
                            size: mobileLayout ? height / 50 : height / 45,
                          ),
                  ),
                ),
                const SizedBox(width: 5.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
