import 'package:flutter/material.dart';
import 'package:freequiz/loading/loading_screen/animation.dart';

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
      body: LoadingAnimation(
        message: widget.message,
        finishedLoading: widget.finishedLoading,
        widget: widget.widget,
      ),
    );
  }
}
