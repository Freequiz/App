import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/api/api.dart';
import 'package:freequiz/loading/error_loading/view.dart';
import 'package:freequiz/loading/loading_screen/view.dart';
import 'package:freequiz/loading/no_connection/no_connection.dart';

void nothing() {}

Widget loading({
  required AsyncSnapshot<Map<dynamic, dynamic>> data,
  required Widget previousWidget,
  required Widget widget,
  required BuildContext context,
  Function onLoad = nothing,
}) {
  if (data.hasData) {
    if (data.data!['success']) {
      onLoad();
      return widget;
    }
    if (data.data!["message"] == Api.noConnection || data.data!["message"] == Api.timeout) {
      if (data.data!.containsKey('offline_data')) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) {
              return const NoConnectionAlert();
            },
          );
        });
        onLoad();
        return widget;
      }
    }
    return ErrorLoadingView(
      error: data.data!["message"],
      widget: previousWidget,
    );
  }
  if (data.hasError) {
    return ErrorLoadingView(
      error: "other error",
      widget: previousWidget,
    );
  }
  return LoadingScreen(
    message: "Loading Quiz",
    finishedLoading: false,
    appBar: AppBar(
      title: const Text('loading').tr(),
    ),
  );
}
