import 'package:flutter/material.dart';
import '../models/game.dart';
import 'game_item.dart';

class GamesList extends StatelessWidget {
  const GamesList(this.games, {super.key});

  final List<Game> games;

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
        itemBuilder: (context, index) => GameItem(games[index]),
      ),
    );
  }
}
