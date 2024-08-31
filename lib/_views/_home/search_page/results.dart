import 'package:flutter_animate/flutter_animate.dart';
import 'package:freequiz/_views/_home/search_page/search.dart';
import 'package:freequiz/_views/subviews/buttons/load_more.dart';
import 'package:freequiz/services/api/quizzes.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class Results extends StatefulWidget {
  final Widget child;
  final int i;
  final bool onChanged;
  final int shownList;
  final int previousShownList;
  final String searchTerm;
  final Function refreshChildren;
  final Function endAnimation;
  final bool more;

  const Results({
    super.key,
    required this.child,
    required this.i,
    required this.onChanged,
    required this.shownList,
    required this.previousShownList,
    required this.searchTerm,
    required this.refreshChildren,
    required this.endAnimation,
    required this.more
  });

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ListView(
        children: [
          widget.child,
          SizedBox(
            height: context.mobileLayout ? 10 : 15,
          ),
          LoadMoreButton(
            onPressed: () => onPressed(widget.i),
            pressed: pressed,
            more: widget.more,
          ),
        ],
      )
          .animate(target: widget.onChanged ? 1 : 0)
          .moveX(
            begin: context.screenWidth * (widget.i - widget.previousShownList),
            end: context.screenWidth * (widget.i - widget.shownList),
            duration: const Duration(milliseconds: 200),
          )
          .callback(
        callback: (_) {
          if (widget.i != 0) return; //only call this once
          widget.endAnimation();
        },
      ),
    );
  }

  onPressed(int i) async {
    setState(() => pressed = true);

    if (i == 0) { // Quizzes Search List
      Search.pageQuizzes++;
      final newQuizzes = await APIQuizzes.search(widget.searchTerm, Search.pageQuizzes);
      Search.quizzes.addAll(newQuizzes['data']);
      Search.moreQuizzes = newQuizzes['next_page'];
    }
    else {
      Search.pageUsers++;
      final newUsers = await APIUsers.search(widget.searchTerm, Search.pageUsers);
      Search.users.addAll(newUsers['data']);
      Search.moreUsers = newUsers['next_page'];
    }

    widget.refreshChildren();
    setState(() => pressed = false);
  }
}
