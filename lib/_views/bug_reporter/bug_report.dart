import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/bug_reporter/bug_report_page.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class BugReporter extends StatelessWidget {
  const BugReporter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('bug reporter').tr(),
      ),
      body: const BugReportPage()
    );
  }
}
