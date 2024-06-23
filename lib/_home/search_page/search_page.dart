import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freequiz/_home/search_page/lists.dart';
import 'package:freequiz/_home/search_page/switcher.dart';
import 'package:freequiz/_views/badge.dart';
import 'package:freequiz/_home/search_page/language_selector.dart';
import 'package:freequiz/_home/search_page/search.dart';
import 'package:freequiz/_views/buttons/load_more.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/api/users.dart';
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

  bool pressed = false;

  int shownList = 0;
  int previousShownList = 0;
  bool onChanged = false;

  refresh() {
    setState(() {});
  }

  bool refreshChildren = false; // variable changes back and forth between true and false to refresh children

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
                list(
                  SearchListQuizzes(
                    refresh: refreshChildren,
                  ),
                  0,
                ),
                list(
                  SearchListUsers(
                    refresh: refreshChildren,
                  ),
                  1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget list(Widget child, int i) {
    return Positioned.fill(
      child: ListView(
        children: [
          child,
          SizedBox(
            height: context.mobileLayout ? 5 : 15,
          ),
          LoadMoreButton(
            onPressed: onPressed,
            pressed: pressed,
          ),
        ],
      )
          .animate(target: onChanged ? 1 : 0)
          .moveX(
            begin: context.screenWidth * (i - previousShownList),
            end: context.screenWidth * (i - shownList),
            duration: const Duration(milliseconds: 200),
          )
          .callback(
        callback: (_) {
          if (i != 0) return; //only call this once
          setState(() {
            previousShownList = shownList;
            onChanged = false;
          });
        },
      ),
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

  onPressed() async {
    setState(() {
      pressed = true;
    });

    Search.page++;

    final newQuizzes = APIQuizzes.search(widget.searchTerm, Search.page);
    final newUsers = APIUsers.search(widget.searchTerm, Search.page);

    Search.quizzes.addAll((await newQuizzes)['data']);
    Search.users.addAll((await newUsers)['data']);

    setState(() {
      refreshChildren = !refreshChildren;
      pressed = false;
    });
  }
}
