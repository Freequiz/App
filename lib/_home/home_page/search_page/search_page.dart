import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/quiz_tile.dart';
import 'package:freequiz/_home/home_page/search_page/language_selector.dart';
import 'package:freequiz/_home/home_page/search_page/search.dart';
import 'package:freequiz/_home/home_page/search_page/search_filter.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class SearchPage extends StatefulWidget {
  final int n;
  final String searchTerm;
  const SearchPage({super.key, this.n = 0, required this.searchTerm});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final arrow = '\u279C';
  bool pressed = false;
  int page = 1;

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DeviceInfo.mobileLayout ? 10 : 30),
      child: Column(
        children: [
          SizedBox(
            height: DeviceInfo().height() / 20,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SearchFilter(
                  color: color2,
                  child: Text(
                    "${language["Results for"]} \"${trim(widget.searchTerm)}\"",
                    style: TextStyle(
                        fontSize: DeviceInfo().height() / 50, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () => onTap(),
                  child: SearchFilter(
                    color: color5,
                    child: Text(
                      Search.from == 'Any' && Search.to == 'Any'
                          ? language["Language"]
                          : "${language[Search.from] ?? Search.from} $arrow ${language[Search.to] ?? Search.to}",
                      style: TextStyle(
                          fontSize: DeviceInfo().height() / 50,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: DeviceInfo.mobileLayout ? 10 : 25,
          ),
          Expanded(
            child: ListView(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Search.data.length,
                  itemBuilder: (BuildContext context, int i) {
                    return QuizTile(
                      data: Search.data[i],
                      uuid: Search.data[i]['id'],
                      expanded: false,
                      width: DeviceInfo.mobileLayout ? DeviceInfo().width() - 20 : DeviceInfo().width() - 60,
                    );
                  },
                  separatorBuilder: (BuildContext context, int i) {
                    return SizedBox(
                      height: DeviceInfo.mobileLayout ? 10 : 25,
                    );
                  },
                ),
                SizedBox(
                  height: DeviceInfo.mobileLayout ? 5 : 15,
                ),
                pressed
                    ? Align(
                        child: CircularProgressIndicator(
                          color: DeviceInfo.darkMode ? Colors.white : color1,
                        ),
                      )
                    : Align(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: color1,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () => onPressed(),
                          child: Text(
                            language["Load more"],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: DeviceInfo().height() / 55),
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

  onPressed() async {
    setState(() {
      pressed = true;
    });
    page++;
    Search.data.addAll(
      (await APIQuizzes().httpGetSearch(widget.searchTerm, page))['data'],
    );
    setState(() {
      pressed = false;
    });
  }
}
