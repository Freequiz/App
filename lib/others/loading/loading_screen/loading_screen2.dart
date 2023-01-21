import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen2 extends StatefulWidget {
  final String message;
  final bool finishedLoading;
  final Widget widget;
  const LoadingScreen2(
      {super.key,
      required this.message,
      this.finishedLoading = false,
      this.widget = const Drawer()});

  @override
  State<LoadingScreen2> createState() => _LoadingScreen2State();
}

class _LoadingScreen2State extends State<LoadingScreen2> {
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstCurve: Curves.ease,
      secondCurve: Curves.easeIn,
      duration: const Duration(milliseconds: 450),
      firstChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.finishedLoading
              ? Image.asset(
                  "images/icon_transparent.png",
                )
              : SpinKitRotatingCircle(
                  size: DeviceInfo.width / 2.25,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      "images/icon_transparent.png",
                    );
                  },
                ),
          SizedBox(
            height: widget.finishedLoading ? 0 : DeviceInfo.height / 30,
          ),
          Text(
            language[widget.message],
            style:
                TextStyle(fontSize: widget.finishedLoading ? 0 : DeviceInfo.height / 45),
          ),
        ],
      ),
      secondChild: SizedBox(
          width: DeviceInfo.width,
          height: DeviceInfo.height -
              kToolbarHeight -
              MediaQuery.of(context).padding.top -
              AppBar().preferredSize.height,
          child: widget.widget),
      crossFadeState: widget.finishedLoading
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
    );
  }
}
