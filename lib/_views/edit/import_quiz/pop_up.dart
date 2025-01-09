import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/import_quiz/import.dart';
import 'package:freequiz/controllers/edit/import.dart';
import 'package:freequiz/utilities/imports/base.dart';

class ImportPopUp extends StatelessWidget {
  final Function refresh;
  const ImportPopUp({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return AlertDialog(
      title: const Text("import quiz").tr(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("import quiz text").tr(),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 200
            ),
            child: TextField(
              controller: textController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("close").tr(),
            ),
            TextButton(
              onPressed: () {
                Import.main(textController.value.text);
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ImportQuiz(refresh: refresh),
                ));
              },
              child: const Text("done").tr(),
            ),
          ],
        )
      ],
    );
  }
}
