import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

import '../../../others/utilities.dart';

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
    final hintColor = DeviceInfo.darkMode ? Colors.white : textGray;
    return Container(
      height: DeviceInfo().height() / 18,
      padding: EdgeInsets.all(
          DeviceInfo.mobileLayout ? 0 : DeviceInfo().height() / 80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DeviceInfo().width() / 30.4),
          topRight: Radius.circular(DeviceInfo().width() / 30.4),
        ),
        color: color1,
      ),
      child: conditional(
        search,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
          child: TextField(
            onChanged: (value) {
              widget.search(textController.text);
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
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: color2,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: color1,
                  width: 2,
                ),
                borderRadius:
                    BorderRadius.circular(DeviceInfo().width() / 30.4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: color4,
                  width: 2,
                ),
                borderRadius:
                    BorderRadius.circular(DeviceInfo().width() / 30.4),
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
        ),
        defaultWidget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 5.0),
            Container(
              width: DeviceInfo.mobileLayout
                  ? (DeviceInfo().width() - 30) / 2 - DeviceInfo().height() / 30
                  : (DeviceInfo().width() - 30) / 2 -
                      DeviceInfo().height() / 20 -
                      DeviceInfo().height() / 80,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  language["Definition"],
                  style: TextStyle(
                      fontSize: DeviceInfo.mobileLayout
                          ? DeviceInfo().height() / 50
                          : DeviceInfo().height() / 45),
                ),
              ),
            ),
            Container(
              width: DeviceInfo.mobileLayout
                  ? (DeviceInfo().width() - 30) / 2 - DeviceInfo().height() / 30
                  : (DeviceInfo().width() - 30) / 2 -
                      DeviceInfo().height() / 20 -
                      DeviceInfo().height() / 80,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  language["Answer"],
                  style: TextStyle(
                      fontSize: DeviceInfo.mobileLayout
                          ? DeviceInfo().height() / 50
                          : DeviceInfo().height() / 45),
                ),
              ),
            ),
            SizedBox(
              width: DeviceInfo().height() / 20,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    search = !search;
                  });
                },
                child: Icon(
                  Icons.search,
                  color: DeviceInfo.darkMode ? Colors.white : textGray,
                  size: DeviceInfo.mobileLayout
                      ? DeviceInfo().height() / 50
                      : DeviceInfo().height() / 45,
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
