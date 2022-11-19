import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/quiz_tile.dart';
import 'package:freequiz/api/api.dart';
import 'package:freequiz/others/language.dart';

class SearchPage extends StatefulWidget {
  final ScrollPhysics physics;
  final int n;
  final Map uuids;
  final String searchTerm;
  const SearchPage(
      {super.key,
      this.physics = const ScrollPhysics(),
      this.n = 0,
      required this.uuids, required this.searchTerm});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final color6 = darkMode
        ? const Color.fromARGB(255, 55, 55, 55)
        : const Color.fromARGB(255, 235, 235, 235);
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return Padding(
      padding: EdgeInsets.all(mobileLayout ? 10 : 30),
      child: Column(
        children: [
          Text("${language["Results for"]} \"${widget.searchTerm}\"", style: TextStyle(fontSize: height / 45),),
          SizedBox(
            height: mobileLayout ? 10 : 30,
          ),
          Expanded(
            child: ListView.separated(
              physics: widget.physics,
              itemCount: widget.uuids.length,
              itemBuilder: (BuildContext context, int i) {
                String uuid = widget
                    .uuids[(mobileLayout ? i : i * 2 + widget.n).toString()]!;
                return FutureBuilder<Map>(
                  future: getQuiz(uuid, false),
                  builder: (context, quiz) {
                    if (quiz.hasData) {
                      quiz.data!['data']['title'];
                      return QuizTile(
                        data: quiz.data!['data'],
                        uuid: uuid,
                        expanded: false,
                      );
                    } else if (quiz.hasError) {
                      return Drawer(child: Text('${quiz.error}'));
                    }
                    return Container(
                      height: mobileLayout
                          ? height / 30 * 4.5 + 15
                          : height / 30 * 4.5 + 35,
                      width: width - 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height / 100),
                        color: color6,
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int i) {
                return SizedBox(
                  height: mobileLayout ? 10 : 30,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  half() {
    double half = widget.uuids.length / 2;
    if (half.remainder(1) != 0) {
      if (widget.n == 0) {
        return (half + 0.5).toInt();
      }
      return (half - 0.5).toInt();
    }
    return half.toInt();
  }
}
