import 'package:freequiz/utilities/imports/base.dart';

class TileTitle extends StatelessWidget {
  const TileTitle({super.key, required this.title, this.button = const SizedBox(), this.color});

  final String title;
  final Widget button;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight/ 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: FontSize.title,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          button
        ],
      ),
    );
  }
}
