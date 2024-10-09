import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/quiz_form.dart';
import 'package:freequiz/_views/subviews/edit/answer_textfield.dart';
import 'package:freequiz/_views/subviews/edit/basic_textfield.dart';
import 'package:freequiz/utilities/imports/base.dart';

class WordPairView extends StatelessWidget {
  final WordPair wordPair;
  final Function onDismissed;
  final Function save;
  final Function onSubmitted;
  final int i;
  final String answerLanguage;
  final String definitionLanguage;

  const WordPairView({
    super.key,
    required this.wordPair,
    required this.onDismissed,
    required this.save,
    required this.onSubmitted,
    required this.i,
    required this.answerLanguage,
    required this.definitionLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(wordPair.definition.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed(),
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.screenHeight/ 100),
          color: Colors.red,
        ),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: Column(
        children: [
          BasicTextField(
            textFieldData: wordPair.definition,
            hintError: context.tr('definition error'),
            save: save,
            language: i == 0 ? " ($definitionLanguage)" : "",
          ),
          AnswerTextField(
            textFieldData: wordPair.answer,
            onSubmitted: onSubmitted,
            save: save,
            language: i == 0 ? " ($answerLanguage)" : "",
          ),
        ],
      ),
    );
  }
}
