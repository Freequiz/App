import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/created_quizzes/list_quizzes.dart';
import 'package:freequiz/services/local_storage/draft_storage.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ProgressPopUp extends StatefulWidget {
  final String title;
  final Future<Map> response;
  final Function refresh;
  const ProgressPopUp({super.key, required this.title, required this.response, required this.refresh});

  @override
  State<ProgressPopUp> createState() => _ProgressPopUpState();
}

class _ProgressPopUpState extends State<ProgressPopUp> {
  bool closeButton = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr(widget.title),
        style: TextStyle(color: context.darkMode ? Colors.white : gray40),
      ),
      content: FutureBuilder(
        future: widget.response,
        builder: (context, data) {
          if (data.hasData) {
            if (data.data!['success']) {
              closeButton = false;
              close(data);
              return Text(
                context.tr('quiz saved'),
                style: const TextStyle(color: Colors.green),
              );
            }
            return Text(
              context.tr(data.data!['message'] ?? 'other error description'),
            );
          }
          if (data.hasError) {
            return Text(
              context.tr('other error description'),
            );
          }
          return const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: roseMiddle,
              )
            ],
          );
        },
      ),
      actions: [
        Conditional(
          condition: closeButton,
          widget: TextButton(
            onPressed: closeButton ? () => Navigator.of(context).pop() : () {},
            child: const Text('close').tr(),
          ),
        ),
      ],
    );
  }

  close(data) {
    final quiz = data.data!['quiz_data'];

    if (widget.title == 'Create Quiz') {
      ListQuizzes.data.insert(0, quiz);
    }

    DraftStorage.deleteDraft();
    QuizHelper.draft.clear();
    
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
      widget.refresh();
    });
  }
}
