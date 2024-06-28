import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/quiz_tile/draft.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class Draft extends StatelessWidget {
  final Function refresh;
  const Draft({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            context.tr('draft'),
            style: titleStyle(),
          ),
        ),
        Space.height(context.mobileLayout ? 5 : 15),
        DraftTile(
          refresh: refresh,
        ),
        Space.height(context.mobileLayout ? 15 : 45),
      ],
    );
  }
}
