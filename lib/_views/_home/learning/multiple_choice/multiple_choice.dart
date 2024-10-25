import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/controllers/home/learning/multiple_choice.dart';
import 'package:freequiz/_views/_home/learning/multiple_choice/multiple_choice_body.dart';
import 'package:freequiz/controllers/quiz/question.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:provider/provider.dart';

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({super.key});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  @override
  void initState() {
    Question.randomChoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MultipleChoiceController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'multiple choice',
          style: TextStyle(color: Colors.white),
        ).tr(),
        backgroundColor: context.darkMode ? beigeDark : beigeLight,
        foregroundColor: Colors.white,
      ),
      body: MultipleChoiceBody(
        choices: Question.choices,
        color: beige,
        controller: controller,
      ),
    );
  }
}
