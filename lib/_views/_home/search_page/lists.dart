import 'package:freequiz/_views/_home/search_page/search.dart';
import 'package:freequiz/_views/_home/search_page/user_tile.dart';
import 'package:freequiz/_views/subviews/quiz_tile/quiz_tile.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:freequiz/utilities/widgets/space.dart';

class SearchListUsers extends StatelessWidget {
  final bool refresh;

  const SearchListUsers({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
     return ListView.separated(
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Search.users.length,
      itemBuilder: (BuildContext context, int i) {
        return UserTile(
          data: Search.users[i],
          width: context.mobileLayout ? context.screenWidth - 20 : context.screenWidth - 60,
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return Space.height(10);
      },
    );
  }
}

class SearchListQuizzes extends StatelessWidget {
  final bool refresh;

  const SearchListQuizzes({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Search.quizzes.length,
      itemBuilder: (BuildContext context, int i) {
        return QuizTile(
          data: Search.quizzes[i],
          uuid: Search.quizzes[i]['id'],
          expanded: false,
          width: context.mobileLayout ? context.screenWidth - 20 : context.screenWidth - 60,
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return Space.height(10);
      },
    );
  }
}