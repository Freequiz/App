import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/1_edit/quiz_form.dart';
import 'package:freequiz/1_edit/visibility_options.dart';
import 'package:freequiz/_views/edit/basic_textfield.dart';
import 'package:freequiz/_views/edit/dropdown.dart';
import 'package:freequiz/others/languages.dart';
import 'package:freequiz/utilities/imports/base.dart';

class EditHeader extends StatefulWidget {
  final QuizForm quiz;
  final Function save;
  final Color hintColor;

  const EditHeader({super.key, required this.quiz, required this.save, required this.hintColor});

  @override
  State<EditHeader> createState() => _EditHeaderState();
}

class _EditHeaderState extends State<EditHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.screenHeight/ 100),
        color: context.darkMode ? gray55 : blueLight,
      ),
      child: Padding(
        padding: EdgeInsets.all(context.screenHeight/ 100),
        child: Column(
          children: [
            BasicTextField(
              textFieldData: widget.quiz.title,
              hintError: context.tr('title error'),
              colorBorder: (context.darkMode ? beigeLight : grayFreequiz),
              widthBorder: 3.0,
              save: widget.save,
            ),
            const SizedBox(
              height: 5,
            ),
            BasicTextField(
              textFieldData: widget.quiz.description,
              hintError: context.tr('description error'),
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              save: widget.save,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Dropdown(
                  initialValue: widget.quiz.definitionLanguage,
                  items: Languages.languages,
                  onChanged: (int definitionLanguage) => widget.quiz.definitionLanguage = definitionLanguage,
                  hintColor: widget.hintColor,
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: grayFreequiz,
                ),
                Dropdown(
                  initialValue: widget.quiz.answerLanguage,
                  items: Languages.languages,
                  onChanged: (int answerLanguage) => widget.quiz.answerLanguage = answerLanguage,
                  hintColor: widget.hintColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  VisibilityOptions.icons[widget.quiz.visibility],
                  color: grayFreequiz,
                  size: 24,
                ),
                const SizedBox(width: 15),
                Dropdown(
                  initialValue: widget.quiz.visibility,
                  items: VisibilityOptions.visibilites,
                  onChanged: (String visibility) => setState(() {
                    widget.quiz.visibility = visibility;
                  }),
                  hintColor: widget.hintColor,
                ),
                const SizedBox(width: 39),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
