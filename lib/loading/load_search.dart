import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/search_page/search.dart';
import 'package:freequiz/_home/home_page/search_page/search_page.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/loading/error_loading/error_loading.dart';
import 'package:freequiz/loading/loading_screen/loading_screen.dart';

loadSearch({required BuildContext context, required String searchTerm, mode = "Quiz"}) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return FutureBuilder<Map>(
          future: mode == "Quiz" ? APIQuizzes.search(searchTerm, 1) : APIUsers.search(searchTerm, 1),
          builder: (context, searchResults) {
            if (searchResults.hasData) {
              if (searchResults.data!["success"]) {
                Search.data = searchResults.data!["data"];
                return LoadingScreen(
                  message: "Loading Search Results",
                  finishedLoading: true,
                  widget: SearchPage(
                    searchTerm: searchTerm,
                    mode: mode,
                  ),
                  appBar: AppBar(
                    title: const Text('search').tr(),
                  ),
                );
              }
              return ErrorLoading(
                error: searchResults.data!["message"],
              );
            } else if (searchResults.hasError) {
              return const ErrorLoading(
                error: "other error",
              );
            }
            return LoadingScreen(
              message: "Loading Search Results",
              appBar: AppBar(
                title: const Text('loading').tr(),
              ),
            );
          },
        );
      },
    ),
  );
}
