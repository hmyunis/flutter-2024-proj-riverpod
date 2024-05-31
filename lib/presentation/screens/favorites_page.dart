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
                          itemBuilder: ((context, index) => Dismissible(
                                key: Key(allGames[index].title),
                                onDismissed: (direction) {
                                  if (direction ==
                                      DismissDirection.endToStart) {
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
                                  } else if (direction ==
                                      DismissDirection.startToEnd) {
                                    if (index >= value[0].length) {
                                      ref
                                          .read(collectionListProvider(ref
                                                  .read(userSessionProvider)
                                                  .id!)
                                              .notifier)
                                          .unPinGameInCollection(
                                              allGames[index])
                                          .whenComplete(
                                        () {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
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
                                                      'You pinned ${allGames[index].title}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              backgroundColor: Colors.blueGrey
                                                  .withOpacity(0.7),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: const EdgeInsets.fromLTRB(
                                                  10, 0, 10, 10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      ref
                                          .read(collectionListProvider(ref
                                                  .read(userSessionProvider)
                                                  .id!)
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
