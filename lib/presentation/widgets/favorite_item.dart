import 'package:flutter/material.dart';
import '../models/game.dart';
import '../screens/game_detail_page.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({super.key, required this.game});
  final Game game;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        game.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
      tileColor: Colors.blueGrey,
      subtitle: Text(
        game.description,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Colors.grey,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Image.asset(game.imageUrl)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailPage(game: game),
          ),
        );
      },
    );
  }
}
