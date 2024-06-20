import 'package:freequiz/models/translation.dart';
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
    final color5 = context.darkMode
        ? gray60
        : white225;
    final color6 = context.darkMode
        ? gray55
        : white235;
    return ListView.builder(
      shrinkWrap: true,
      physics: scrollPhysics,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int i2) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: i2 == 0 && roundedCornersTop
                    ? Radius.circular(width / 30.4)
                    : Radius.zero,
                topRight: i2 == 0 && roundedCornersTop
                    ? Radius.circular(width / 30.4)
                    : Radius.zero,
                bottomLeft: i2 == list.length - 1
                    ? Radius.circular(width / 30.4)
                    : Radius.zero,
                bottomRight: i2 == list.length - 1
                    ? Radius.circular(width / 30.4)
                    : Radius.zero),
            color: i2.remainder(2) == 0 ? color5 : color6,
          ),
          padding: context.mobileLayout ? const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0) : EdgeInsets.all(context.screenHeight/ 80),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: context.mobileLayout
                      ? (width - 30) / 2 - context.screenHeight/ 30
                      : (width - 30) / 2 - context.screenHeight/ 20 - context.screenHeight/ 80,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      list[i2].word,
                      style: TextStyle(
                          fontSize: context.mobileLayout ? context.screenHeight/ 60 : context.screenHeight/ 45),
                    ),
                  ),
                ),
                Container(
                  width: context.mobileLayout
                      ? (width - 30) / 2 - context.screenHeight/ 30
                      : (width - 30) / 2 - context.screenHeight/ 20 - context.screenHeight/ 80,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      list[i2].translation,
                      style: TextStyle(
                          fontSize: context.mobileLayout ? context.screenHeight/ 60 : context.screenHeight/ 45),
                    ),
                  ),
                ),
                SizedBox(
                  width: context.screenHeight/ 20,
                  child: TextButton(
                    onPressed: () {
                      markWord(list[i2]);
                    },
                    child: list[i2].favorite
                        ? Icon(
                            Icons.star,
                            color: color,
                            size: context.mobileLayout ? context.screenHeight/ 50 : context.screenHeight/ 45,
                          )
                        : Icon(
                            Icons.star_border,
                            color: color,
                            size: context.mobileLayout ? context.screenHeight/ 50 : context.screenHeight/ 45,
                          ),
                  ),
                ),
              ],
            ),
        );
      },
    );
  }
}
