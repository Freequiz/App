import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/controllers/home/search.dart';
import 'package:freequiz/_views/_home/search_page/search_page.dart';
import 'package:freequiz/loading/loading.dart';
import 'package:freequiz/loading/loading_screen/view.dart';
import 'package:provider/provider.dart';

Future<bool> loadSearch({required BuildContext context, required String searchTerm, mode = "Quiz"}) {
  Search.searchTerm = searchTerm;

  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return LoadSearch(
          searchTerm: searchTerm,
          mode: mode,
        );
      },
    ),
  ).then((context) => Search.shown = false);
}

class LoadSearch extends StatelessWidget {
  final String searchTerm;
  final String mode;

  const LoadSearch({super.key, required this.searchTerm, required this.mode});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: Search.search(searchTerm),
      builder: (context, searchResults) {
        return loading(
          data: searchResults,
          previousWidget: this,
          widget: LoadingScreen(
            message: "Loading Search Results",
            finishedLoading: true,
            widget: ChangeNotifierProvider(
              create: (_) => Search(),
              child: SearchPage(mode: mode),
            ),
            appBar: AppBar(
              title: const Text('search').tr(),
            ),
          ),
          context: context,
          onLoad: () {
            Search.quizzes = searchResults.data!['quizzes']['data'];
            Search.moreQuizzes = searchResults.data!['quizzes']['next_page'];
            Search.users = searchResults.data!['users']['data'];
            Search.moreUsers = searchResults.data!['users']['next_page'];
          },
        );
      },
    );
  }
}
