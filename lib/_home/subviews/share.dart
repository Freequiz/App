import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final String url;
  final Color color;
  const ShareButton({super.key, required this.url, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        Share.share(url);
      },
      child: Icon(
        Icons.ios_share,
        color: color,
      ),
    );
  }
}
