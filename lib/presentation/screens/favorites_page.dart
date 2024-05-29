import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/collection_provider.dart';
import '../../providers/user_session_provider.dart';
import '../widgets/favorite_item.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
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

                  return ListView.separated(
                      itemBuilder: ((context, index) => Dismissible(
                            key: Key(allGames[index].title),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                ref
                                    .read(collectionListProvider(
                                            ref.read(userSessionProvider).id!)
                                        .notifier)
                                    .removeGameFromCollection(allGames[index]);
                                allGames.remove(allGames[index]);
                              } else if (direction ==
                                  DismissDirection.startToEnd) {
                                if (index >= value[0].length) {
                                  ref
                                      .read(collectionListProvider(
                                              ref.read(userSessionProvider).id!)
                                          .notifier)
                                      .unPinGameInCollection(allGames[index]);
                                } else {
                                  ref
                                      .read(collectionListProvider(
                                              ref.read(userSessionProvider).id!)
                                          .notifier)
                                      .pinGameInCollection(allGames[index]);
                                }
                              }
                            },
                            background: Container(
                              color: Colors.blue,
                              padding: const EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                  (index >= value[0].length)
                                      ? Icons.push_pin_rounded
                                      : Icons.push_pin_outlined,
                                  color: Colors.white,
                                  size: 30),
                            ),
                            secondaryBackground: Container(
                              color: Colors.red,
                              padding: const EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              child: const Icon(Icons.delete,
                                  color: Colors.white, size: 30),
                            ),
                            child: FavoriteItem(
                              game: allGames[index],
                              tileColor: ((index < value[0].length)
                                  ? Colors.blueGrey[800]?.withOpacity(0.4)
                                  : Colors.blueGrey),
                              isNotPinned: (index < value[0].length),
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
