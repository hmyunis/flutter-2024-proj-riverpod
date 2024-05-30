import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/collection_provider.dart';
import '../../models/game.dart';
import '../../providers/user_session_provider.dart';
import '../screens/about_page.dart';
import '../screens/game_detail_page.dart';
// import '../screens/screens/game_detail_page.dart';

class GameItem extends ConsumerStatefulWidget {
  const GameItem(this.game, this.isStarred, {super.key});

  final Game game;
  final bool isStarred;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameItemState();
}

class _GameItemState extends ConsumerState<GameItem> {
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
                  widget.game.title.length > 15
                      ? '${widget.game.title.substring(0, 15)}...'
                      : widget.game.title,
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
                  if (widget.isStarred) {
                    ref
                        .read(collectionListProvider(
                                ref.read(userSessionProvider).id!)
                            .notifier)
                        .removeGameFromCollection(widget.game);
                  } else {
                    ref
                        .read(collectionListProvider(
                                ref.read(userSessionProvider).id!)
                            .notifier)
                        .addGameToCollection(widget.game);
                  }
                },
                icon: widget.isStarred
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
