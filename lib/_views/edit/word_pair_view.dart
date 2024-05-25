import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/quiz_form.dart';
import 'package:freequiz/_views/edit/answer_textfield.dart';
import 'package:freequiz/_views/edit/basic_textfield.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';

class WordPairView extends StatefulWidget {
  final WordPair wordPair;
  final Function onDismissed;
  final Function save;
  final Function onSubmitted;

  const WordPairView({
    super.key,
    required this.wordPair,
    required this.onDismissed,
    required this.save,
    required this.onSubmitted,
  });

  @override
  State<WordPairView> createState() => _WordPairViewState();
}

class _WordPairViewState extends State<WordPairView> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.wordPair.definition.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => widget.onDismissed(),
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
          color: DeviceInfo.darkMode ? const Color.fromARGB(255, 55, 55, 55) : blueFreequiz,
        ),
        child: Padding(
          padding: EdgeInsets.all(DeviceInfo().height() / 100),
          child: Column(
            children: [
              BasicTextField(
                textFieldData: widget.wordPair.definition,
                hintError: context.tr('definition error'),
                save: widget.save,
              ),
              const SizedBox(
                height: 5,
              ),
              AnswerTextField(
                textFieldData: widget.wordPair.answer,
                onSubmitted: widget.onSubmitted,
                save: widget.save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
