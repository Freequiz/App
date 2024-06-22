import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/badge.dart';
import 'package:freequiz/_views/quiz_tile/quiz_tile.dart';
import 'package:freequiz/_home/search_page/language_selector.dart';
import 'package:freequiz/_home/search_page/search.dart';
import 'package:freequiz/_home/search_page/user_tile.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/loading/load_search.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

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
      padding: EdgeInsets.all(context.mobileLayout ? 10 : 30),
      child: Column(
        children: [
          SizedBox(
            height: context.screenHeight/ 20,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                InfoBadge(
                  color: roseLight,
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
                    color: blueLight,
                    text: context.tr(Search.mode),
                  ),
                )
              ],
            ),
          ),
          Space.height(context.mobileLayout ? 10 : 25),
          Expanded(
            child: ListView(
              children: [
                Search.mode == "Quiz" ? listQuizzes() : listUsers(),
                SizedBox(
                  height: context.mobileLayout ? 5 : 15,
                ),
                Conditional(
                  condition: pressed,
                  widget: Align(
                    child: CircularProgressIndicator(
                      color: context.darkMode ? Colors.white : grayFreequiz,
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
                            fontSize: context.screenHeight/ 55),
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
          width: context.mobileLayout
              ? context.screenWidth - 20
              : context.screenWidth - 60,
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return Space.height(context.mobileLayout ? 10 : 25);
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
          width: context.mobileLayout
              ? context.screenWidth - 20
              : context.screenWidth - 60,
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return Space.height(context.mobileLayout ? 10 : 25);
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
