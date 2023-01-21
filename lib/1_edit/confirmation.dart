import 'package:flutter/material.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';

class Confirmation extends StatelessWidget {
  final Function refresh;
  final String uuid;
  const Confirmation({super.key, required this.refresh, required this.uuid});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        language["Delete Quiz"],
        style: TextStyle(color: DeviceInfo.darkMode ? Colors.white : Colors.black),
      ),
      content: Text(language[
          "Are you sure you want to delete your quiz. It's not reversible"]),
      actions: [
        FutureBuilder<Map>(
          future: APIQuizzes().httpGetDeleteTokenQuiz(uuid),
          builder: (context, data) {
            if (data.hasData) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await APIQuizzes().httpDeleteQuiz(data.data!["token"], uuid);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        refresh();
                      },
                      child: Text(
                        language["Delete Quiz"],
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(language["Close"]),
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
