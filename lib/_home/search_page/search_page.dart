import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_home/search_page/lists.dart';
import 'package:freequiz/_home/search_page/results.dart';
import 'package:freequiz/_home/search_page/switcher.dart';
import 'package:freequiz/_views/badge.dart';
import 'package:freequiz/_home/search_page/language_selector.dart';
import 'package:freequiz/_home/search_page/search.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class SearchPage extends StatefulWidget {
  final int n;
  final String searchTerm;
  final String mode;
  const SearchPage({super.key, this.n = 0, required this.searchTerm, this.mode = "Quiz"});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final arrow = '\u279C';

  final List<String> options = ['Quiz', 'User'];

  int shownList = 0;
  int previousShownList = 0;
  bool onChanged = false;

  refresh() {
    setState(() {});
  }

  bool refreshChildren = false; // variable changes back and forth between true and false to refresh children

  toggleRefreshChildren() {
    setState(() {
      refreshChildren = !refreshChildren;
    });
  }

  endAnimation() {
    setState(() {
      previousShownList = shownList;
      onChanged = false;
    });
  }

  onTap(String value) {
    setState(() {
      onChanged = true;
      shownList = options.indexOf(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchSwitcher(onTap: onTap, options: options),
        SizedBox(
          height: context.mobileLayout ? 10 : 30,
        ),
        Container(
          height: context.screenHeight / 20,
          padding: EdgeInsets.symmetric(horizontal: context.mobileLayout ? 10.0 : 30),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              InfoBadge(
                color: roseLight,
                text: context.tr('results for', args: [widget.searchTerm.truncate(32)]),
              ),
              Space.width(8),
              GestureDetector(
                onTap: () => selectLanguage(),
                child: InfoBadge(
                  color: purpleLight,
                  text: Search.from == 'Any' && Search.to == 'Any'
                      ? context.tr('language')
                      : context.tr('fromto', args: [Search.from.tr(), Search.to.tr()]),
                ),
              ),
            ],
          ),
        ),
        Space.height(context.mobileLayout ? 10 : 25),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mobileLayout ? 10.0 : 30),
            child: Stack(
              children: [
                Results(
                  i: 0,
                  onChanged: onChanged,
                  refreshChildren: toggleRefreshChildren,
                  searchTerm: widget.searchTerm,
                  shownList: shownList,
                  previousShownList: previousShownList,
                  endAnimation: endAnimation,
                  child: SearchListQuizzes(
                    refresh: refreshChildren,
                  ),
                ),
                Results(
                  i: 1,
                  onChanged: onChanged,
                  refreshChildren: toggleRefreshChildren,
                  searchTerm: widget.searchTerm,
                  shownList: shownList,
                  previousShownList: previousShownList,
                  endAnimation: endAnimation,
                  child: SearchListUsers(
                    refresh: refreshChildren,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
}
