import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/loading/error_loading/alert.dart';
import 'package:freequiz/utilities/imports/base.dart';

class ErrorLoadingView extends StatelessWidget {
  final String error;
  final Widget widget;
  final List<String>? argument;
  const ErrorLoadingView({super.key, required this.error, required this.widget, this.argument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('loading').tr(),
      ),
      body: Container(
        color: context.darkMode ? const Color.fromARGB(255, 30, 30, 30) : null,
        child: ErrorLoadingAlert(
          error: error,
          previousWidget: widget,
          backgroundColor: context.darkMode ? gray40 : null,
          argument: argument,
        ),
      ),
    );
  }
}
