import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/quiz_tile.dart';
import 'package:freequiz/_home/home_page/search_page/language_selector.dart';
import 'package:freequiz/_home/home_page/search_page/search.dart';
import 'package:freequiz/_home/home_page/search_page/search_filter.dart';
import 'package:freequiz/_home/home_page/search_page/user_tile.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/loading/load_search.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/string_extensions.dart';
import 'package:freequiz/others/style.dart';

import '../../../others/utilities.dart';

class SearchPage extends StatefulWidget {
  final int n;
  final String searchTerm;
  final String mode;
  const SearchPage(
      {super.key, this.n = 0, required this.searchTerm, this.mode = "Quiz"});

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
                    "${language["Results for"]} \"${widget.searchTerm.triming(32)}\"",
                    style: TextStyle(
                        fontSize: DeviceInfo().height() / 50,
                        color: Colors.white),
                  ),
                ),
                Space.width(10),
                GestureDetector(
                  onTap: () => selectLanguage(),
                  child: SearchFilter(
                    color: color5,
                    child: Text(
                      Search.from == 'Any' && Search.to == 'Any'
                          ? language["Language"]
                          : "${language[Search.from] ?? Search.from} $arrow ${language[Search.to] ?? Search.to}",
                      style: TextStyle(
                        fontSize: DeviceInfo().height() / 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () => changeMode(),
                  child: SearchFilter(
                    color: color4,
                    child: Text(
                      Search.mode.transl(),
                      style: TextStyle(
                        fontSize: DeviceInfo().height() / 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Space.height(DeviceInfo.mobileLayout ? 10 : 25),
          Expanded(
            child: ListView(
              children: [
                Search.mode == "Quiz" ? listQuizzes() : listUsers(),
                SizedBox(
                  height: DeviceInfo.mobileLayout ? 5 : 15,
                ),
                conditional(
                  pressed,
                  Align(
                    child: CircularProgressIndicator(
                      color: DeviceInfo.darkMode ? Colors.white : color1,
                    ),
                  ),
                  defaultWidget: Align(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listQuizzes() {
    return ListView.separated(
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Search.data.length,
      itemBuilder: (BuildContext context, int i) {
        return QuizTile(
          data: Search.data[i],
          uuid: Search.data[i]['id'],
          expanded: false,
          width: DeviceInfo.mobileLayout
              ? DeviceInfo().width() - 20
              : DeviceInfo().width() - 60,
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return Space.height(DeviceInfo.mobileLayout ? 10 : 25);
      },
    );
  }

  Widget listUsers() {
    return ListView.separated(
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Search.data.length,
      itemBuilder: (BuildContext context, int i) {
        return UserTile(
          data: Search.data[i],
          width: DeviceInfo.mobileLayout
              ? DeviceInfo().width() - 20
              : DeviceInfo().width() - 60,
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return Space.height(DeviceInfo.mobileLayout ? 10 : 25);
      },
    );
  }

  selectLanguage() {
    showDialog(
      context: context,
      builder: (BuildContext context) => LanguageSelector(
        refresh: refresh,
      ),
    );
  }

  changeMode() {
    if (Search.mode == "Quiz") {
      Search.mode = "User";
    } else {
      Search.mode = "Quiz";
    }
    reload();
  }

  reload() {
    loadSearch(
        context: context, searchTerm: widget.searchTerm, mode: Search.mode);
  }

  onPressed() async {
    setState(() {
      pressed = true;
    });
    page++;
    Search.data.addAll(
      Search.mode == "Quiz"
          ? (await APIQuizzes.search(widget.searchTerm, page))['data']
          : (await APIUsers.search(widget.searchTerm, page))['data'],
    );
    setState(() {
      pressed = false;
    });
  }
}
