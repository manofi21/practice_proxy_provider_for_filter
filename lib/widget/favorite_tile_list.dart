
import 'package:flutter/material.dart';

class FavoriteTileList extends StatefulWidget {
  final bool favorite;
  final void Function(bool) onFavChange;
  const FavoriteTileList({
    Key? key,
    required this.favorite,
    required this.onFavChange,
  }) : super(key: key);

  @override
  State<FavoriteTileList> createState() => _FavoriteTileListState();
}

class _FavoriteTileListState extends State<FavoriteTileList> {
  late bool fav;

  @override
  void initState() {
    super.initState();
    fav = widget.favorite;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Favorite"),
        IconButton(
          onPressed: () {
            setState(() {
              fav = !fav;
              widget.onFavChange(fav);
            });
          },
          icon: Icon(
            fav ? Icons.favorite : Icons.favorite_border,
          ),
        )
      ],
    );
  }
}
