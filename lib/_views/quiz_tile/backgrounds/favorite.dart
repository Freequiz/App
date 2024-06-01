import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';

class BackgroundFavorite extends StatelessWidget {
  const BackgroundFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
        color: grayFreequiz,
      ),
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Stack(
            children: [
              Icon(
                Icons.star_outline_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}