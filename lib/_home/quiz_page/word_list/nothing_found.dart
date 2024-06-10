import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/utilities.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';

class NothingFound extends StatelessWidget {
  const NothingFound({super.key});

  @override
  Widget build(BuildContext context) {
    final color5 = context.darkMode
        ? gray60
        : white225;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return Container(
      width: context.screenWidth - 20,
      height: context.screenHeight / 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(context.screenWidth / 30.4),
          bottomRight: Radius.circular(context.screenWidth / 30.4),
        ),
        color: color5,
      ),
      child: Padding(
        padding: EdgeInsets.all(mobileLayout ? 0 : context.screenHeight / 80),
        child: Center(
          child: Text(
            context.tr('nothing found'),
            style: textSize(mobileLayout ? context.screenHeight / 50 : context.screenHeight / 45),
          ),
        ),
      ),
    );
  }
}
