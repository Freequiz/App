import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/subviews/quiz_tile/draft.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class Draft extends StatelessWidget {
  final Function refresh;
  const Draft({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: QuizHelper.draft.isNotEmpty,
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.tr('draft'),
                style: titleStyle(),
              ),
            ),
            SizedBox(height: context.mobileLayout ? 5 : 15),
            DraftTile(
              refresh: refresh,
            ),
            SizedBox(height: context.mobileLayout ? 15 : 45),
          ],
        ),
      ),
    );
  }
}
