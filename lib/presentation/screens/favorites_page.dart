import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/game.dart';
import '../../providers/collection_provider.dart';
import '../../providers/user_session_provider.dart';
import '../widgets/favorite_item.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  Future<void> _showPinUnPinConfirmationDialog(Game game, String action) async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${action.toUpperCase()} Game'),
          content: Text('Are you sure you want to $action ${game.title}?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.blue[100],
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (confirmed != null && confirmed) {
      if (action.toLowerCase() == 'pin') {
        ref
            .read(collectionListProvider(ref.read(userSessionProvider).id!)
                .notifier)
            .unPinGameInCollection(game)
            .whenComplete(() {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.push_pin,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      'You pinned ${game.title}',
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
        });
      }
      if (action.toLowerCase() == 'unpin') {
        ref
            .read(collectionListProvider(ref.read(userSessionProvider).id!)
                .notifier)
            .pinGameInCollection(game)
            .whenComplete(() {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.push_pin_outlined,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      'You unpinned ${game.title}',
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
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List> collectionsListProvider =
        ref.watch(collectionListProvider(ref.read(userSessionProvider).id!));
    return Container(
      child: switch (collectionsListProvider) {
        AsyncData(:final value) => Column(
            children: [
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(16.0),
                child: const Text('Favorites',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5,
                    )),
              ),
              Expanded(
                child: Builder(builder: (context) {
                  final allGames = [...value[0], ...value[1]];
                  return (allGames.isEmpty)
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.collections_bookmark_outlined,
                                color: Colors.grey.withOpacity(0.5),
                                size: 100,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "You have no favorites...",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: ((context, index) => GestureDetector(
                                onLongPress: () {
                                  if (index >= value[0].length) {
                                    _showPinUnPinConfirmationDialog(
                                        allGames[index], 'pin');
                                  } else {
                                    _showPinUnPinConfirmationDialog(
                                        allGames[index], 'unpin');
                                  }
                                },
                                child: Dismissible(
                                  key: Key(allGames[index].title),
                                  onDismissed: (direction) {
                                    ref
                                        .read(collectionListProvider(ref
                                                .read(userSessionProvider)
                                                .id!)
                                            .notifier)
                                        .removeGameFromCollection(
                                            allGames[index])
                                        .whenComplete(() {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            children: [
                                              const Icon(
                                                Icons.delete_rounded,
                                                size: 32.0,
                                                color: Colors.red,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  'You removed ${allGames[index].title} from favorites.',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          backgroundColor:
                                              Colors.red[300]?.withOpacity(0.5),
                                          behavior: SnackBarBehavior.floating,
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    padding: const EdgeInsets.only(right: 20),
                                    alignment: Alignment.centerRight,
                                    child: const Icon(Icons.delete,
                                        color: Colors.white, size: 30),
                                  ),
                                  direction: DismissDirection.endToStart,
                                  child: FavoriteItem(
                                    game: allGames[index],
                                    tileColor: ((index < value[0].length)
                                        ? Colors.blueGrey[800]?.withOpacity(0.4)
                                        : Colors.blueGrey),
                                    isNotPinned: (index < value[0].length),
                                  ),
                                ),
                              )),
                          separatorBuilder: ((context, index) =>
                              const SizedBox(height: 5)),
                          itemCount: allGames.length);
                }),
              ),
            ],
          ),
        AsyncError() => const Scaffold(
            body: Center(
              child: Text("Error, please try again"),
            ),
          ),
        _ => const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          ),
      },
    );
  }
}
