import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class Confirmation extends StatefulWidget {
  final Function refresh;
  const Confirmation({super.key, required this.refresh});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  bool destroyQuizzes = false;

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(
        context.tr('delete account'),
        style: TextStyle(color: context.darkMode ? Colors.white : Colors.black),
      ),
      content: const Text('delete account confirmation').tr(),
      actions: [
        Row(
          children: [
            const Text('delete all quizzes').tr(),
            Checkbox(
                value: destroyQuizzes,
                onChanged: (value) {
                  setState(() {
                    destroyQuizzes = value ?? false;
                  });
                },
              ),
          ],
        ),
        FutureBuilder<Map>(
          future: APIUsers.getDeleteToken(),
          builder: (context, data) {
            if (data.hasData) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      key: ValueKey("confirmDeletionButton"),
                      onPressed: () async {
                        await APIUsers.deleteAccount(data.data!["token"], destroyQuizzes);
                        if (context.mounted) Navigator.of(context).pop();
                        widget.refresh();
                      },
                      child: Text(
                        context.tr('delete account'),
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
              return const Center(
                  child: Padding(
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
