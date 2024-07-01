import 'package:freequiz/utilities/imports/base.dart';

class InfoBadge extends StatelessWidget {
  const InfoBadge({super.key, required this.color, required this.text});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(100)),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: FontSize.item,
          ),
        ),
      ),
    );
  }
}
