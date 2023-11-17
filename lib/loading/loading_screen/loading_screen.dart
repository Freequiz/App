import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freequiz/others/string_extensions.dart';

import '../../others/utilities.dart';

class LoadingScreen extends StatefulWidget {
  final String message;
  final bool finishedLoading;
  final Widget widget;
  final AppBar appBar;
  const LoadingScreen(
      {super.key,
      required this.message,
      this.finishedLoading = false,
      this.widget = const Drawer(),
      required this.appBar});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCrossFade(
              firstCurve: Curves.ease,
              secondCurve: Curves.easeIn,
              duration: const Duration(milliseconds: 350),
              firstChild: Column(
                children: [
                  conditional(
                    widget.finishedLoading,
                    Image.asset(
                      "images/icon_transparent.png",
                    ),
                    defaultWidget: SpinKitRotatingCircle(
                      size: DeviceInfo().width() / 2.25,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(
                          "images/icon_transparent.png",
                        );
                      },
                    ),
                  ),
                  Space.height(
                      widget.finishedLoading ? 0 : DeviceInfo().height() / 30),
                  Text(
                    widget.message.transl(),
                    style: textSize(widget.finishedLoading
                        ? 0
                        : DeviceInfo().height() / 45),
                  ),
                ],
              ),
              secondChild: SizedBox(
                width: DeviceInfo().width(),
                height: DeviceInfo().height() -
                    (MediaQuery.of(context).padding.top + kToolbarHeight) -
                    1,
                child: widget.widget,
              ),
              crossFadeState: widget.finishedLoading
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            ),
          ],
        ),
      ),
    );
  }
}
