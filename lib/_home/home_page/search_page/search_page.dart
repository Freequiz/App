import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/badge.dart';
import 'package:freequiz/_views/quiz_tile/quiz_tile.dart';
import 'package:freequiz/_home/home_page/search_page/language_selector.dart';
import 'package:freequiz/_home/home_page/search_page/search.dart';
import 'package:freequiz/_home/home_page/search_page/user_tile.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/loading/load_search.dart';
import 'package:freequiz/others/device_info.dart';
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
                InfoBadge(
                  color: roseFreequiz,
                  text: 
                    context.tr('results for', args: [widget.searchTerm.truncate(32)]),
                ),
                Space.width(8),
                GestureDetector(
                  onTap: () => selectLanguage(),
                  child: InfoBadge(
                    color: purpleFreequiz,
                    text: Search.from == 'Any' && Search.to == 'Any'
                          ? context.tr('language')
                          : context.tr('fromto', args: [Search.from.tr(), Search.to.tr()]),
                  ),
                ),
                Space.width(8),
                GestureDetector(
                  onTap: () => changeMode(),
                  child: InfoBadge(
                    color: blueFreequiz,
                    text: context.tr(Search.mode),
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
                      color: DeviceInfo.darkMode ? Colors.white : grayFreequiz,
                    ),
                  ),
                  defaultWidget: Align(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: grayFreequiz,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => onPressed(),
                      child: Text(
                        context.tr('load more'),
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
