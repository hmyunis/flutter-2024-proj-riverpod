import 'package:flutter/material.dart';
import '../../models/game.dart';
import 'game_item.dart';

class GamesList extends StatefulWidget {
  const GamesList(this.games, this.favoriteGameIds, {super.key});

  final List<Game> games;
  final List<int> favoriteGameIds;

  @override
  State<GamesList> createState() => _GamesListState();
}

class _GamesListState extends State<GamesList> {
  List<String> genres = [
    'All',
    'Shooter',
    'Action',
    'Horror',
    'Fighting',
    'Anime',
    'RPG',
    'Strategy',
    'Racing',
    'Sports'
  ];
  String selectedGenre = 'All';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Wrap(
            spacing: 3.0,
            children: genres.map((genre) {
              return FilterChip(
                label: Text(
                  genre,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                selected: selectedGenre == genre,
                selectedColor: Colors.blueGrey[800],
                backgroundColor: Colors.blueGrey,
                selectedShadowColor: Colors.blueGrey,
                checkmarkColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: const BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
                onSelected: (selected) {
                  setState(() {
                    selectedGenre = genre;
                  });
                },
              );
            }).toList(),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
                childAspectRatio: 0.7,
              ),
              itemCount: selectedGenre == 'All'
                  ? widget.games.length
                  : widget.games
                      .where((game) => game.genre == selectedGenre)
                      .length,
              itemBuilder: (context, index) {
                final game = selectedGenre == 'All'
                    ? widget.games[index]
                    : widget.games
                        .where((game) => game.genre == selectedGenre)
                        .toList()[index];

                if (widget.favoriteGameIds.contains(widget.games[index].id)) {
                  return GameItem(game, true);
                }
                return GameItem(game, false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
