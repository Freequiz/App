import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/loading/error_loading/alert.dart';

class ErrorLoadingView extends StatelessWidget {
  final String error;
  final Widget widget;
  const ErrorLoadingView({super.key, required this.error, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('loading').tr(),
      ),
      body: Container(
        color: const Color.fromARGB(255, 30, 30, 30),
        child: ErrorLoadingAlert(
          error: error,
          previousWidget: widget,
        ),
      ),
    );
  }
}
