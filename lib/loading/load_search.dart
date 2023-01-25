import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/search_page/search.dart';
import 'package:freequiz/_home/home_page/search_page/search_page.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/loading/error_loading/error_loading.dart';
import 'package:freequiz/loading/loading_screen/loading_screen.dart';
import 'package:freequiz/others/string_extensions.dart';

loadSearch({required BuildContext context, required String searchTerm}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return FutureBuilder<Map>(
            future: APIQuizzes().httpGetSearch(searchTerm, 1),
            builder: (context, searchResults) {
              if (searchResults.hasData) {
                if (searchResults.data!["success"]) {
                  Search.data = searchResults.data!["data"];
                  return LoadingScreen(
                    message: "Loading Search Results",
                    finishedLoading: true,
                    widget: SearchPage(
                      searchTerm: searchTerm,
                    ),
                    appBar: AppBar(
                      title: Text("Search".transl()),
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
                  title: Text("Loading".transl()),
                ),
              );
            },
          );
        },
      ),
    );
  }