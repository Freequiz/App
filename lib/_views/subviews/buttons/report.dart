import 'package:freequiz/_views/subviews/alerts/report.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ReportButton extends StatelessWidget {
  const ReportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => report(context),
      child: const Icon(
        Icons.report,
        size: 24,
      ),
    );
  }

  report(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const ReportAlert(),
    );
  }
}