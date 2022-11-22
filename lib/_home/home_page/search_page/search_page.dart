import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/quiz_tile.dart';
import 'package:freequiz/_home/home_page/search_page/language_selector.dart';
import 'package:freequiz/_home/home_page/search_page/search.dart';
import 'package:freequiz/_home/home_page/search_page/search_filter.dart';
import 'package:freequiz/api/api.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class SearchPage extends StatefulWidget {
  final ScrollPhysics physics;
  final int n;
  final Map uuids;
  final String searchTerm;
  const SearchPage(
      {super.key,
      this.physics = const ScrollPhysics(),
      this.n = 0,
      required this.uuids,
      required this.searchTerm});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final arrow = '\u279C';

  refresh() {
    setState(() {});
  }

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
          SizedBox(
            height: height / 20,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SearchFilter(
                  color: color2,
                  child: Text(
                    "${language["Results for"]} \"${trim(widget.searchTerm)}\"",
                    style:
                        TextStyle(fontSize: height / 50, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    onTap();
                  },
                  child: SearchFilter(
                    color: color5,
                    child: Text(
                      Search.from == "Any" && Search.to == "Any"
                          ? language["Language"]
                          : "${language[Search.from]} $arrow ${language[Search.to]}",
                      style:
                          TextStyle(fontSize: height / 50, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: mobileLayout ? 10 : 30,
          ),
          Expanded(
            child: ListView(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: widget.physics,
                  itemCount: widget.uuids.length,
                  itemBuilder: (BuildContext context, int i) {
                    String uuid = widget.uuids[
                        (mobileLayout ? i : i * 2 + widget.n).toString()]!;
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
                              ? height / 30 * 2.5 + 15
                              : height / 30 * 2.5 + 35,
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
                SizedBox(
                  height: mobileLayout ? 5 : 15,
                ),
                Align(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: color1,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Text(
                      language["Load more"],
                      style:
                          TextStyle(color: Colors.white, fontSize: height / 55),
                    ),
                  ),
                ),
              ],
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

  trim(String searchTerm) {
    final String trimmedSearchTerm = searchTerm.characters.take(20).toString();
    if (trimmedSearchTerm.length == searchTerm.length) {
      return trimmedSearchTerm;
    }
    return '$trimmedSearchTerm...';
  }

  onTap() {
    showDialog(
      context: context,
      builder: (BuildContext context) => LanguageSelector(
        refresh: refresh,
      ),
    );
  }
}
