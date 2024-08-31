import 'package:freequiz/_views/edit/edit_create_quiz/edit_quiz.dart';
import 'package:freequiz/_views/subviews/alerts/report.dart';
import 'package:freequiz/_views/subviews/kebab_menu/kebab_menu_item.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:share_plus/share_plus.dart';

class KebabMenuButton extends StatelessWidget {
  final String url;
  final Color? color;
  final String uuid;
  const KebabMenuButton({super.key, required this.url, this.color, required this.uuid});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => KebabMenu(
            url: url,
            uuid: uuid,
          ),
        );
      },
      child: Icon(
        Icons.more_vert_rounded,
        color: color,
      ),
    );
  }
}

class KebabMenu extends StatefulWidget {
  final String url;
  final String uuid;
  const KebabMenu({super.key, required this.url, required this.uuid});

  @override
  State<KebabMenu> createState() => _KebabMenuState();
}

class _KebabMenuState extends State<KebabMenu> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(vertical: 2.0),
      buttonPadding: const EdgeInsets.all(0.0),
      actions: [
        KebabMenuItem(
          onTap: () => share,
          icon: Icons.ios_share_rounded,
          text: "Share",
        ),
        Container(
          color: context.darkMode ? gray40 : white205,
          height: 2.0,
        ),
        KebabMenuItem(
          onTap: () => edit,
          icon: Icons.edit,
          text: "Edit",
        ),
        Container(
          color: context.darkMode ? gray40 : white205,
          height: 2.0,
        ),
        KebabMenuItem(
          onTap: () => report,
          icon: Icons.report,
          text: "report",
        ),
        Container(
          color: context.darkMode ? gray40 : white205,
          height: 2.0,
        ),
        KebabMenuItem(
          onTap: () => close,
          icon: Icons.close,
          text: "Close",
        ),
      ],
    );
  }

  close() {
    Navigator.of(context).pop();
  }

  edit() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EditQuiz(
            refresh: refresh,
            uuid: widget.uuid,
            owner: QuizHelper.quiz!.owner,
          );
        },
      ),
    );
  }

  report() {
    showDialog(
      context: context,
      builder: (BuildContext context) => const ReportAlert(),
    );
  }

  share() {
    Share.share(widget.url);
  }
}
