import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freequiz/others/utilities.dart';

class LoadingAnimation extends StatefulWidget {
  final String message;
  final bool finishedLoading;
  final Widget widget;
  const LoadingAnimation(
      {super.key, required this.message, this.finishedLoading = false, this.widget = const Drawer()});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitRotatingCircle(
          size: DeviceInfo().width() / 3,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              "images/icon_transparent.png",
            );
          },
        ),
        Space.height(
          DeviceInfo().height() / 30,
        ),
        Text(
          widget.message.tr(),
          style: textSize(DeviceInfo().height() / 45),
        ),
      ],
    )
        .animate(target: widget.finishedLoading ? 1 : 0)
        .fadeOut(duration: const Duration(milliseconds: 200))
        .swap(builder: (_, __) => widget.widget.animate().fadeIn(duration: const Duration(milliseconds: 100)));
  }
}
