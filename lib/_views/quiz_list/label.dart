import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/base.dart';

class QuizListLabel extends StatelessWidget {
  final String text;
  final IconData icon;
  const QuizListLabel({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          Text(context.tr(text), style: titleStyle()),
          const SizedBox(width: 10.0),
          Icon(icon),
        ],
      ),
    );
  }
}