import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final RenderBox box = context.findRenderObject() as RenderBox;
        SharePlus.instance.share(
          ShareParams(text: url, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size),
        );
      },
      icon: Icon(
        Icons.ios_share,
        color: context.darkMode ? Colors.white : gray40,
      ),
    );
  }
}