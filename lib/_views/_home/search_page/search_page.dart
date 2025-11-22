import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/_home/search_page/lists.dart';
import 'package:freequiz/_views/_home/search_page/results.dart';
import 'package:freequiz/_views/_home/search_page/switcher.dart';
import 'package:freequiz/_views/subviews/badge.dart';
import 'package:freequiz/_views/_home/search_page/language_selector.dart';
import 'package:freequiz/controllers/home/search.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  final int n;
  final String mode;
  const SearchPage({super.key, this.n = 0, this.mode = "Quiz"});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final arrow = '\u279C';

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Search>(context);

    return Column(
      children: [
        const SearchSwitcher(),
        SizedBox(
          height: context.mobileLayout ? 10 : 20,
        ),
        Container(
          height: context.screenHeight / 20,
          padding: EdgeInsets.symmetric(horizontal: context.mobileLayout ? 10 : 20),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              InfoBadge(
                color: roseLight,
                text: context.tr('results for', args: [Search.searchTerm.truncate(32)]),
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
        Space.height(context.mobileLayout ? 10 : 20),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mobileLayout ? 10.0 : 20),
            child: Stack(
              children: [
                Results(
                  i: 0,
                  more: Search.moreQuizzes,
                  child: const SearchListQuizzes(),
                ),
                Results(
                  i: 1,
                  more: Search.moreUsers,
                  child: const SearchListUsers(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void selectLanguage() {
    showDialog(
      context: context,
      builder: (BuildContext context) => LanguageSelector(
        refresh: refresh,
      ),
    );
  }
}
