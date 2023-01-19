import 'package:flutter/material.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  final String message;
  final bool finishedLoading;
  final Widget widget;
  final AppBar appBar;
  const LoadingScreen(
      {super.key,
      required this.message,
      required this.finishedLoading,
      this.widget = const Drawer(),
      required this.appBar});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                  widget.finishedLoading
                      ? Image.asset(
                          "images/icon_transparent.png",
                        )
                      : SpinKitRotatingCircle(
                          size: width / 2.25,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.asset(
                              "images/icon_transparent.png",
                            );
                          },
                        ),
                  SizedBox(
                    height: widget.finishedLoading ? 0 : height / 30,
                  ),
                  Text(
                    language[widget.message],
                    style: TextStyle(
                        fontSize: widget.finishedLoading ? 0 : height / 45),
                  ),
                ],
              ),
              secondChild: SizedBox(
                width: width,
                height: height -
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
