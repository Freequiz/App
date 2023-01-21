import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/search_page/search_page.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/loading/error_loading/error_loading.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/loading/loading_screen/loading_screen.dart';
import 'package:freequiz/others/style.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final textController = TextEditingController();
  int page = 1;

  @override
  Widget build(BuildContext context) {
    final hintColor = DeviceInfo.darkMode ? Colors.white : textGray;
    final backgroundColor = DeviceInfo.darkMode
        ? const Color.fromARGB(255, 55, 55, 55)
        : const Color.fromARGB(255, 235, 235, 235);
    return Container(
      height: DeviceInfo.mobileLayout ? DeviceInfo.height / 20 + 20 : 60,
      width: DeviceInfo.mobileLayout ? DeviceInfo.width - 20 : DeviceInfo.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Flexible(
              child: SizedBox(
                height: DeviceInfo.mobileLayout ? DeviceInfo.height / 20 : 40,
                child: TextField(
                  onSubmitted: (value) {
                    search();
                  },
                  keyboardAppearance:
                      DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
                  controller: textController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: DeviceInfo.darkMode
                        ? const Color.fromARGB(255, 45, 45, 45)
                        : const Color.fromARGB(255, 245, 245, 245),
                    contentPadding: const EdgeInsets.all(10.0),
                    border: const OutlineInputBorder(),
                    hintText: language["Search"],
                    suffixIcon: IconButton(
                      color: hintColor,
                      onPressed: () {
                        textController.clear();
                      },
                      icon: const Icon(
                        Icons.clear,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              height: DeviceInfo.mobileLayout ? DeviceInfo.height / 20 : 40,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: color1,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  search();
                },
                child: const Icon(Icons.search_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }

  search() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return FutureBuilder<Map>(
            future: APIQuizzes().httpGetSearch(textController.text, page),
            builder: (context, searchResults) {
              if (searchResults.hasData) {
                if (searchResults.data!["success"]) {
                  return LoadingScreen(
                    message: "Loading Search Results",
                    finishedLoading: true,
                    widget: SearchPage(
                      data: searchResults.data!["data"],
                      searchTerm: textController.text,
                    ),
                    appBar: AppBar(
                      title: Text(language["Search"]),
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
                finishedLoading: false,
                widget: const SearchPage(
                  data: [],
                  searchTerm: "",
                ),
                appBar: AppBar(
                  title: Text(language["Loading"]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
