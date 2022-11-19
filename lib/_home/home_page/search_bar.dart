import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/search_page.dart';
import 'package:freequiz/api/api.dart';
import 'package:freequiz/others/language.dart';
import 'package:freequiz/others/loading_screen.dart';
import 'package:freequiz/others/style.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final hintColor = darkMode ? Colors.white : textGray;
    final backgroundColor = darkMode
        ? const Color.fromARGB(255, 55, 55, 55)
        : const Color.fromARGB(255, 235, 235, 235);
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return Container(
      height: mobileLayout ? height / 20 + 20 : 60,
      width: mobileLayout ? width - 20 : width / 2,
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
                height: mobileLayout ? height / 20 : 40,
                child: TextField(
                  onSubmitted: (value) {
                    search();
                  },
                  keyboardAppearance:
                      darkMode ? Brightness.dark : Brightness.light,
                  controller: textController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: darkMode
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
            future: httpSearch(textController.text),
            builder: (context, searchResults) {
              if (searchResults.hasData) {
                return LoadingScreen(
                  message: "Loading Search Results",
                  finishedLoading: true,
                  widget: SearchPage(uuids: searchResults.data!, searchTerm: textController.text,),
                  appBar: AppBar(
                    title: Text(language["Search"]),
                  ),
                );
              } else if (searchResults.hasError) {
                return Drawer(child: Text('${searchResults.error}'));
              }
              return LoadingScreen(
                message: "Loading Search Results",
                finishedLoading: false,
                widget: const SearchPage(uuids: {}, searchTerm: "",),
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
