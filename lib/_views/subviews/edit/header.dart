import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/visibility_options.dart';
import 'package:freequiz/_views/subviews/edit/basic_textfield.dart';
import 'package:freequiz/_views/subviews/edit/dropdown.dart';
import 'package:freequiz/controllers/edit/quiz_form.dart';
import 'package:freequiz/controllers/others/languages.dart';
import 'package:freequiz/utilities/imports/base.dart';

class EditHeader extends StatefulWidget {
  final QuizForm quiz;
  final Function save;
  final Color hintColor;
  final Function refresh;

  const EditHeader({super.key, required this.quiz, required this.save, required this.hintColor, required this.refresh});

  @override
  State<EditHeader> createState() => _EditHeaderState();
}

class _EditHeaderState extends State<EditHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: context.darkMode ? gray60 : white225,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          BasicTextField(
            textFieldData: widget.quiz.title,
            hintError: context.tr('title error'),
            save: widget.save,
            textFieldColor: context.darkMode ? const Color.fromARGB(255, 45, 45, 45) : white245,
            bottomRadius: true,
          ),
          const SizedBox(
            height: 10,
          ),
          BasicTextField(
            textFieldData: widget.quiz.description,
            hintError: context.tr('description error'),
            maxLines: 4,
            keyboardType: TextInputType.multiline,
            save: widget.save,
            textFieldColor: context.darkMode ? const Color.fromARGB(255, 45, 45, 45) : white245,
            bottomRadius: true,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Dropdown(
                  initialValue: widget.quiz.definitionLanguage,
                  items: Languages.languages,
                  onChanged: (int definitionLanguage) {
                    widget.quiz.definitionLanguage = definitionLanguage;
                    widget.refresh();
                  },
                  color: rose,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.arrow_forward_rounded,
                color: context.darkMode ? rose.light : rose.dark,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Dropdown(
                  initialValue: widget.quiz.answerLanguage,
                  items: Languages.languages,
                  onChanged: (int answerLanguage) {
                    widget.quiz.answerLanguage = answerLanguage;
                    widget.refresh();
                  },
                  color: rose,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Dropdown(
            leadingIcon: Icon(
              VisibilityOptions.icons[widget.quiz.visibility],
              color: context.darkMode ? blue.light : blue.dark,
              size: 24,
            ),
            initialValue: widget.quiz.visibility,
            items: VisibilityOptions.visibilites,
            onChanged: (String visibility) => setState(() {
              widget.quiz.visibility = visibility;
            }),
            color: blue,
            width: 150,
          ),
        ],
      ),
    );
  }
}
