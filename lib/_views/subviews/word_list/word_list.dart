import 'package:freequiz/models/translation.dart';
import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/utilities/imports/base.dart';

class WordList extends StatelessWidget {
  final List<Translation> list;
  final Function markWord;
  final int i;
  final Color color;
  final ScrollPhysics scrollPhysics;
  final double width;
  final bool roundedCornersTop;
  const WordList({
    super.key,
    required this.list,
    required this.markWord,
    this.i = 0,
    required this.color,
    this.scrollPhysics = const ScrollPhysics(),
    required this.width,
    this.roundedCornersTop = true,
  });

  @override
  Widget build(BuildContext context) {
    final color5 = context.darkMode ? gray60 : white235;
    final color6 = context.darkMode ? gray55 : white225;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: roundedCornersTop ? const Radius.circular(13) : Radius.zero,
          topRight: roundedCornersTop ? const Radius.circular(13) : Radius.zero,
          bottomLeft: const Radius.circular(13),
          bottomRight: const Radius.circular(13),
        ),
        color: color5,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: scrollPhysics,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int i2) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    list[i2].word,
                    style: TextStyle(
                        fontSize: FontSize.text, color: Learning.errors.contains(list[i2]) ? Colors.red : null),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    list[i2].translation,
                    style: TextStyle(
                        fontSize: FontSize.text, color: Learning.errors.contains(list[i2]) ? Colors.red : null),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  markWord(list[i2]);
                },
                icon: list[i2].favorite
                    ? Icon(
                        Icons.star,
                        color: color,
                        size: 20,
                      )
                    : Icon(
                        Icons.star_border,
                        color: color,
                        size: 20,
                      ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int _) {
          return Container(
            height: 1.5,
            color: color6,
          );
        },
      ),
    );
  }
}
