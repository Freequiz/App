import 'package:freequiz/_views/edit/quiz_form.dart';
import 'package:freequiz/_views/subviews/edit/word_pair_view.dart';
import 'package:freequiz/utilities/imports/base.dart';

class ListWordPairs extends StatefulWidget {
  final QuizForm quiz;
  final String mode;
  final Function refresh;

  const ListWordPairs({super.key, required this.quiz, required this.mode, required this.refresh});

  @override
  State<ListWordPairs> createState() => _ListWordPairsState();
}

class _ListWordPairsState extends State<ListWordPairs> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.quiz.wordPairs.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: context.screenHeight/ 60,
        );
      },
      itemBuilder: (BuildContext context, int i) {
        WordPair wordPair = widget.quiz.wordPairs[i];

        return WordPairView(
          wordPair: wordPair,
          onDismissed: () => setState(() {
            widget.quiz.removeWordPair(i);
            widget.refresh();
          }),
          save: () => widget.quiz.save(mode: widget.mode),
          onSubmitted: () => onSubmitted(i),
        );
      },
    );
  }

  onSubmitted(int i) {
    setState(() {
      if (widget.quiz.wordPairs[i].definition.input.text != "" && widget.quiz.wordPairs[i].answer.input.text != "") {
        if (i + 2 >= widget.quiz.wordPairs.length) {
          widget.quiz.addWordPair();
        }
        FocusScope.of(context).nextFocus();
      }
    });
    widget.refresh();
  }
}
