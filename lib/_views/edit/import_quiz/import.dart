import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/edit_create_quiz/error_pop_up.dart';
import 'package:freequiz/_views/edit/edit_create_quiz/progress_pop_up.dart';
import 'package:freequiz/_views/subviews/edit/edit_view.dart';
import 'package:freequiz/controllers/edit/import.dart';
import 'package:freequiz/services/api/quizzes.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ImportQuiz extends StatefulWidget {
  final Function refresh;
  const ImportQuiz({super.key, required this.refresh});

  @override
  State<ImportQuiz> createState() => _ImportQuizState();
}

class _ImportQuizState extends State<ImportQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('create quiz').tr(),
        leading: TextButton(
          onPressed: () {
            Import.quiz.save(mode: 'create');
            Navigator.of(context).pop();
            widget.refresh();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () => onPressed(),
            child: Text(
              context.tr('done'),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Import.quiz.save(mode: 'create');
        },
        child: Padding(
          padding: context.mobileLayout
              ? const EdgeInsets.all(10.0)
              : EdgeInsets.symmetric(horizontal: context.screenWidth / 5.5, vertical: 10.0),
          child: EditView(quiz: Import.quiz, mode: 'create'),
        ),
      ),
    );
  }

  void onPressed() async {
    Import.quiz.checkForErrors();

    if (Import.quiz.error) {
      setState(() {});
    }

    if (Import.quiz.counter < 3) {
      showDialog(context: context, builder: (BuildContext context) => const ErrorPopUp());
    }

    if (!Import.quiz.error) {
      final map = Import.quiz.createMap();
      final response = APIQuizzes.createQuiz(map);

      showDialog(
        context: context,
        builder: (context) => ProgressPopUp(
          title: 'Create Quiz',
          response: response,
          refresh: (_) => widget.refresh(),
        ),
      );
    }
  }
}
