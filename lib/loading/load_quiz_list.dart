import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/subviews/quiz_list/quiz_list.dart';
import 'package:freequiz/services/api/api.dart';
import 'package:freequiz/loading/no_connection/no_connection.dart';
import 'package:freequiz/utilities/imports/base.dart';

class LoadQuizList extends StatelessWidget {
  final Future<Map> future;
  final Function onDismissed;
  final Widget background;
  const LoadQuizList({super.key, required this.future, required this.onDismissed, required this.background});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: future,
      builder: (context, data) {
        if (data.hasData) {
          if (data.data!['success']) {
            final List list = data.data!['data'] as List;

            return QuizList(list: list, onDismissed: onDismissed, background: background);
          }
          if (data.data!['message'] == Api.noConnection || data.data!['message'] == Api.timeout) {
            if (data.data!.containsKey('offline_data')) {
              final List list = data.data!['data'] as List;

              return QuizList(list: list, onDismissed: onDismissed, background: background);
            }
            return NoConnectionAlert(
              backgroundColor: context.darkMode ? gray55 : null,
              showButton: false,
            );
          }
          return Text(
              context.tr('${data.error ?? data.data?["token"] ?? "other error"}'),
              style: titleStyle(),
          );
        }
        if (data.hasError) {
          return Text(
              context.tr('${data.error ?? "other error"}'),
              style: titleStyle(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
