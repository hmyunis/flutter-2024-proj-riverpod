import 'package:flutter/material.dart';
import '../models/game.dart';
import '../screens/game_detail_page.dart';

class GameItem extends StatefulWidget {
  const GameItem(this.game, {super.key});

  final Game game;

  @override
  State<GameItem> createState() => _GameItemState();
}

class _GameItemState extends State<GameItem> {
  final Map<String, Icon> _favorites =
      {}; // Map to store favorite games, title: Icon()

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailPage(game: widget.game),
          ),
        );
      },
      child: Card(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.game.imageUrl,
                fit: BoxFit.fill,
                isAntiAlias: true,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(5),
                child: Text(
                  widget.game.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (_favorites.containsKey(widget.game.title)) {
                      _favorites.remove(widget.game.title);
                    } else {
                      _favorites[widget.game.title] = const Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    }
                  });
                },
                icon: (_favorites.containsKey(widget.game.title))
                    ? _favorites[widget.game.title]!
                    : const Icon(Icons.star_border, color: Colors.amber),
                padding: const EdgeInsets.all(5),
                alignment: Alignment.topRight,
                iconSize: 30,
                highlightColor: Colors.amber[200],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
