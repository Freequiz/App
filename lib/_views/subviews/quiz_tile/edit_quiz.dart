import 'package:freequiz/_views/edit/confirmation.dart';
import 'package:freequiz/_views/subviews/buttons/edit.dart';
import 'package:freequiz/_views/subviews/quiz_tile/backgrounds/delete.dart';
import 'package:freequiz/_views/subviews/quiz_tile/dismissible.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class EditQuizTile extends StatefulWidget {
  final Map data;
  final bool expanded;
  final String uuid;
  final Function refresh;
  const EditQuizTile({super.key, required this.data, required this.uuid, this.expanded = true, required this.refresh});

  @override
  State<EditQuizTile> createState() => _EditQuizTileState();
}

class _EditQuizTileState extends State<EditQuizTile> {
  bool expanded = true;
  bool shown = true;

  @override
  void initState() {
    super.initState();
    expanded = widget.expanded;
  }

  show() {
    widget.refresh();
    setState(() {
      shown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Conditional(
      condition: shown,
      widget: DismissibleQuizTile(
        quizData: widget.data,
        background: const BackgroundDelete(),
        expanded: expanded,
        button: Edit(widget: widget),
        onDismissed: (id) {
          showDialog(
            context: context,
            builder: (BuildContext context) => Confirmation(refresh: show, uuid: widget.uuid),
          );
        },
      ),
    );
  }
}
