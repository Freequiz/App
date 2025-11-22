import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite(
      {super.key, required this.favorite, required this.toggleFavorite});

  final bool favorite;
  final Function toggleFavorite;

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool favorite = false;

  @override
  void initState() {
    favorite = widget.favorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Icon(
        favorite ? Icons.star_rounded : Icons.star_border_rounded,
        size: 30,
        color: favorite ? Colors.yellow : null,
      ),
    );
  }

  void onPressed() {
    widget.toggleFavorite();
    setState(() {
      favorite = !favorite;
    });
  }
}
