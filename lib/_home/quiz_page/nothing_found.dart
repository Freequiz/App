import 'package:flutter/material.dart';
import 'package:freequiz/others/initial_loading.dart';

class NothingFound extends StatefulWidget {
  const NothingFound({super.key});

  @override
  State<NothingFound> createState() => _NothingFoundState();
}

class _NothingFoundState extends State<NothingFound> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final color5 = darkMode
        ? const Color.fromARGB(255, 60, 60, 60)
        : const Color.fromARGB(255, 225, 225, 225);
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return Container(
      width: width - 20,
      height: height / 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width / 30.4),
          bottomRight: Radius.circular(width / 30.4),
        ),
        color: color5,
      ),
      child: Padding(
        padding: EdgeInsets.all(mobileLayout ? 0 : height / 80),
        child: Center(
          child: Text(
            language["Nothing found"],
            style: TextStyle(fontSize: mobileLayout ? height / 50 : height / 45),
          ),
        ),
      ),
    );
  }
}
