import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/quiz_form.dart';
import 'package:freequiz/_views/edit/word_pair_view.dart';
import 'package:freequiz/others/device_info.dart';

class ListWordPairs extends StatefulWidget {
  final QuizForm quiz;

  const ListWordPairs({super.key, required this.quiz});

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
          height: DeviceInfo().height() / 60,
        );
      },
      itemBuilder: (BuildContext context, int i) {
        WordPair wordPair = widget.quiz.wordPairs[i];

        return WordPairView(
          wordPair: wordPair,
          onDismissed: () => setState(() {
            widget.quiz.wordPairs.removeAt(i);
          }),
          save: widget.quiz.save,
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
  }
}
