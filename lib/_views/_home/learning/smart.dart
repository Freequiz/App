import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/_home/learning/multiple_choice/multiple_choice_body.dart';
import 'package:freequiz/_views/_home/learning/writing/writing_body.dart';
import 'package:freequiz/controllers/home/learning/multiple_choice.dart';
import 'package:freequiz/controllers/home/learning/writing.dart';
import 'package:freequiz/controllers/quiz/question.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:provider/provider.dart';

class Smart extends StatefulWidget {
  const Smart({super.key});

  @override
  State<Smart> createState() => _SmartState();
}

class _SmartState extends State<Smart> {
  @override
  void initState() {
    Question.randomChoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<WritingController>(context);
    Provider.of<MultipleChoiceController>(context);

    final modes = [
      MultipleChoiceBody(
        color: purple,
      ),
      WritingBody(
        color: purple,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.darkMode ? purpleDark : purpleLight,
        foregroundColor: Colors.white,
        title: const Text(
          "Smart",
          style: TextStyle(color: Colors.white),
        ).tr(),
      ),
      body: modes[Questionnaire.questions[0].score['smart'] > 0 ? 1 : 0],
    );
  }
}
