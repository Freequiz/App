import 'package:freequiz/utilities/imports/utilities.dart';

class TileTitle extends StatelessWidget {
  const TileTitle({super.key, required this.title, this.button = const SizedBox(), this.dismissButton = const SizedBox(), this.color});

  final String title;
  final Widget button;
  final Widget dismissButton;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
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
          ),
          button,
          LayoutWidget(tablet: dismissButton)
        ],
      ),
    );
  }
}
