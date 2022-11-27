import 'package:flutter/material.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class WordListTaskbar extends StatefulWidget {
  final Function search;
  const WordListTaskbar({super.key, required this.search});

  @override
  State<WordListTaskbar> createState() => _WordListTaskbarState();
}

class _WordListTaskbarState extends State<WordListTaskbar> {
  final textController = TextEditingController();
  bool search = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final hintColor = darkMode ? Colors.white : textGray;
    return Container(
      height: height / 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(width / 30.4),
          topRight: Radius.circular(width / 30.4),
        ),
        color: color1,
      ),
      child: Padding(
        padding: EdgeInsets.all(mobileLayout ? 0 : height / 80),
        child: search
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
                child: TextField(
                  onChanged: (value) {
                    widget.search(textController.text);
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
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: color2,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: color1,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(width / 30.4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: color4,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(width / 30.4),
                    ),
                    hintText: language["Search"],
                    suffixIcon: IconButton(
                      color: hintColor,
                      onPressed: () {
                        textController.clear();
                        setState(() {
                          widget.search("");
                          search = !search;
                        });
                      },
                      icon: const Icon(
                        Icons.clear,
                      ),
                    ),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 5.0),
                  Container(
                    width: mobileLayout
                        ? (width - 30) / 2 - height / 30
                        : (width - 30) / 2 - height / 20 - height / 80,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        language["Definition"],
                        style: TextStyle(
                            fontSize: mobileLayout ? height / 50 : height / 45),
                      ),
                    ),
                  ),
                  Container(
                    width: mobileLayout
                        ? (width - 30) / 2 - height / 30
                        : (width - 30) / 2 - height / 20 - height / 80,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        language["Answer"],
                        style: TextStyle(
                            fontSize: mobileLayout ? height / 50 : height / 45),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: height / 20,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          search = !search;
                        });
                      },
                      child: Icon(
                        Icons.search,
                        color: darkMode ? Colors.white : textGray,
                        size: mobileLayout ? height / 50 : height / 45,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                ],
              ),
      ),
    );
  }
}
