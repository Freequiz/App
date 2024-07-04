import 'package:freequiz/loading/load_user.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:material_symbols_icons/symbols.dart';

class UserButton extends StatelessWidget {
  const UserButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => loadUser(context: context, user: QuizHelper.quiz!.creator),
      child: LayoutWidget(
        mobile: userBadge(context),
        tablet: Container(
          decoration: BoxDecoration(
            color: context.darkMode ? gray60 : white235,
            borderRadius: BorderRadius.circular(13),
          ),
          padding: const EdgeInsets.all(13.0),
          child: Row(
            children: [
              userBadge(context),
              const SizedBox(width: 20.0),
              Flexible(
                child: Text(
                  QuizHelper.quiz!.creator,
                  style: const TextStyle(fontSize: FontSize.title),
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userBadge(BuildContext context) {
    return Container(
      height: context.mobileLayout ? 32 : 42,
      width: context.mobileLayout ? 32 : 42,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: lightBlue),
      child: Center(
        child: Icon(
          Symbols.person,
          size: context.mobileLayout ? 24 : 32,
          color: darkMainColor,
        ),
      ),
    );
  }
}
