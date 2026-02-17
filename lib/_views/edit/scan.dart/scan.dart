import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/edit_create_quiz/error_pop_up.dart';
import 'package:freequiz/_views/edit/edit_create_quiz/progress_pop_up.dart';
import 'package:freequiz/_views/subviews/edit/edit_view.dart';
import 'package:freequiz/controllers/edit/scan.dart';
import 'package:freequiz/services/api/quizzes.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ScanQuiz extends StatefulWidget {
  final Function refresh;
  const ScanQuiz({super.key, required this.refresh});

  @override
  State<ScanQuiz> createState() => _ScanQuizState();
}

class _ScanQuizState extends State<ScanQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('create quiz').tr(),
        leading: TextButton(
          onPressed: () {
            Scan.quiz.save(mode: 'create');
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
          Scan.quiz.save(mode: 'create');
        },
        child: Padding(
          padding: context.mobileLayout
              ? const EdgeInsets.all(10.0)
              : EdgeInsets.symmetric(horizontal: context.screenWidth / 5.5, vertical: 10.0),
          child: EditView(quiz: Scan.quiz, mode: 'create', scanning: true,),
        ),
      ),
    );
  }

  void onPressed() async {
    Scan.quiz.checkForErrors();

    if (Scan.quiz.error) {
      setState(() {});
    }

    if (Scan.quiz.counter < 3) {
      showDialog(context: context, builder: (BuildContext context) => const ErrorPopUp());
    }

    if (!Scan.quiz.error) {
      final map = Scan.quiz.createMap();
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
