import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/game_provider.dart';

import '../../providers/collection_provider.dart';
import '../../models/game.dart';
import '../../providers/user_session_provider.dart';
import '../screens/game_detail_page.dart';

class GameItem extends ConsumerWidget {
  const GameItem(this.game, this.isStarred, {super.key});

  final Game game;
  final bool isStarred;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showCollectionSnackBar(String gameTitle, bool isAdded) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                isAdded ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 32.0,
                color: Colors.amber,
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Text(
                  isAdded
                      ? '$gameTitle is added to favorites.'
                      : '$gameTitle is removed from favorites.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.blueGrey.withOpacity(0.7),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      );
    }

    void showSuccessSnackBar(String message) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.blueGrey.withOpacity(0.7),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailPage(game: game),
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
                game.imageUrl,
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
                  game.title.length > 15
                      ? '${game.title.substring(0, 15)}...'
                      : game.title,
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
                onPressed: () async {
                  if (isStarred) {
                    await ref
                        .read(collectionListProvider(
                                ref.read(userSessionProvider).id!)
                            .notifier)
                        .removeGameFromCollection(game);
                    showCollectionSnackBar(game.title, false);
                  } else {
                    await ref
                        .read(collectionListProvider(
                                ref.read(userSessionProvider).id!)
                            .notifier)
                        .addGameToCollection(game);
                    showCollectionSnackBar(game.title, true);
                  }
                  ref.invalidate(gameListProvider);
                },
                icon: isStarred
                    ? const Icon(Icons.star, color: Colors.amber)
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
