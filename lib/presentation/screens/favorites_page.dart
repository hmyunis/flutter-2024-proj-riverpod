import 'package:flutter/material.dart';
import '../data/favorites.dart';
import '../models/game.dart';
import '../widgets/favorite_item.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  void removeFavorite(Game game) {
    setState(() {
      favorites.remove(game);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Expanded(
                child: Text(
                  '${game.title} has been removed from your favorites.',
                  overflow: TextOverflow.visible,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              TextButton(
                onPressed: () {
                  if (favorites.contains(game) == false) {
                    setState(() {
                      favorites.add(game);
                    });
                  }
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('UNDO'),
              )
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blueGrey, Colors.grey],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ],
          ),
          margin: const EdgeInsets.all(8.0),
          height: 100,
          width: double.maxFinite,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text(
            "F A V O R I T E S",
            style: TextStyle(
              fontSize: 24,
              color: Colors.blue[900],
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: ((context, index) => Dismissible(
                    key: Key(favorites[index].title),
                    onDismissed: (direction) =>
                        removeFavorite(favorites[index]),
                    background: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete,
                          color: Colors.white, size: 30),
                    ),
                    direction: DismissDirection.endToStart,
                    child: FavoriteItem(game: favorites[index]),
                  )),
              separatorBuilder: ((context, index) => const SizedBox(height: 5)),
              itemCount: favorites.length),
        ),
      ],
    );
  }
}
