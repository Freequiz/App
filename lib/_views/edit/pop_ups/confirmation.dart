import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/services/api/quizzes.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class Confirmation extends StatelessWidget {
  final Function refresh;
  final String uuid;
  const Confirmation({super.key, required this.refresh, required this.uuid});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr('delete quiz'),
        style: TextStyle(color: context.darkMode ? Colors.white : Colors.black),
      ),
      content: const Text('confirmation delete quiz').tr(),
      actions: [
        FutureBuilder<Map>(
          future: APIQuizzes.getDeleteToken(uuid),
          builder: (context, data) {
            if (data.hasData) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await APIQuizzes.deleteQuiz(data.data!["token"], uuid);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                        refresh();
                      },
                      child: Text(
                        context.tr('delete quiz'),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('close').tr(),
                    )
                  ],
                ),
              );
            } else if (data.hasError) {
              return Text('${data.error}');
            } else {
              return const Center(child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: CircularProgressIndicator(),
              ));
            }
          },
        ),
      ],
    );
  }
}
