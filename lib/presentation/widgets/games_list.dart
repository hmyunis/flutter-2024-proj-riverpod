import 'package:flutter/material.dart';
import '../../models/game.dart';
import 'game_item.dart';

class GamesList extends StatelessWidget {
  const GamesList(this.games, this.favoriteGameIds, {super.key});

  final List<Game> games;
  final List<int> favoriteGameIds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two columns
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
          childAspectRatio: 0.7,
        ),
        itemCount: games.length,
        itemBuilder: (context, index) {
          if (favoriteGameIds.contains(games[index].id)) {
            return GameItem(games[index], true);
          }
          return GameItem(games[index], false);
        },
      ),
    );
  }
}
