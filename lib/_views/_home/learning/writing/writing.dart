import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/_home/learning/writing/writing_body.dart';
import 'package:freequiz/controllers/home/learning/writing.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:provider/provider.dart';

class Writing extends StatefulWidget {
  const Writing({super.key});

  @override
  State<Writing> createState() => _WritingState();
}

class _WritingState extends State<Writing> {
  @override
  Widget build(BuildContext context) {
    Provider.of<WritingController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'writing',
          style: TextStyle(color: Colors.white),
        ).tr(),
        foregroundColor: Colors.white,
        backgroundColor: context.darkMode ? roseDark : roseLight,
      ),
      body: WritingBody(
        color: rose,
      ),
    );
  }
}
