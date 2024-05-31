import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/collections_repository.dart';
import '../data/repositories/games_repository.dart';
import '../data/services/collections_api_service.dart';
import '../data/services/games_api_service.dart';
import '../models/collection.dart';
import '../models/game.dart';

final collectionListProvider = AsyncNotifierProvider.autoDispose
    .family<CollectionNotifier, List, int>(CollectionNotifier.new);

class CollectionNotifier extends AutoDisposeFamilyAsyncNotifier<List, int> {
  int userId = 0;

  @override
  Future<List> build(int arg) async {
    userId = arg;
    final CollectionsRepository collectionsRepository =
        CollectionsRepository(CollectionsApiService());
    final List<int> unpinnedGameIds =
        await collectionsRepository.getGameIdsByStatus(userId, "UNPINNED");
    final List<int> pinnedGameIds =
        await collectionsRepository.getGameIdsByStatus(userId, "PINNED");

    final List<int> gamesInUsersCollection = [
      ...unpinnedGameIds,
      ...pinnedGameIds
    ];

    final GamesRepository gamesRepository = GamesRepository(GamesApiService());
    final List<Game> games = await gamesRepository.getGames();
    games.retainWhere((game) => gamesInUsersCollection.contains(game.id));

    final pinnedGames = <Game>[];
    final unPinnedGames = <Game>[];

    for (var game in games) {
      if (pinnedGameIds.contains(game.id)) {
        pinnedGames.add(game);
      } else {
        unPinnedGames.add(game);
      }
    }

    return [
      [...pinnedGames],
      [...unPinnedGames],
    ];
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> pinGameInCollection(Game game) async {
    final CollectionsRepository collectionsRepository =
        CollectionsRepository(CollectionsApiService());

    final List<Collection> collections =
        await collectionsRepository.getCollections();
    final col = collections
        .where((collection) =>
            collection.userId == userId && collection.gameId == game.id)
        .toList();
    final collectionId = col[0].id;

    await collectionsRepository.updateCollection(
      collectionId!,
      Collection(
        status: "UNPINNED",
        gameId: game.id!,
        userId: userId,
      ),
    );
    await refresh();
  }

  Future<void> unPinGameInCollection(Game game) async {
    final CollectionsRepository collectionsRepository =
        CollectionsRepository(CollectionsApiService());

    final List<Collection> collections =
        await collectionsRepository.getCollections();
    final col = collections
        .where((collection) =>
            collection.userId == userId && collection.gameId == game.id)
        .toList();
    final collectionId = col[0].id;

    await collectionsRepository.updateCollection(
      collectionId!,
      Collection(
        status: "PINNED",
        gameId: game.id!,
        userId: userId,
      ),
    );
    await refresh();
  }

  Future<void> removeGameFromCollection(Game game) async {
    final CollectionsRepository collectionsRepository =
        CollectionsRepository(CollectionsApiService());

    final List<Collection> collections =
        await collectionsRepository.getCollections();
    final col = collections
        .where((collection) =>
            collection.userId == userId && collection.gameId == game.id)
        .toList();
    final collectionId = col[0].id;

    await collectionsRepository.deleteCollection(collectionId!);
    // await refresh();
  }

  Future<void> addGameToCollection(Game game) async {
    final CollectionsRepository collectionsRepository =
        CollectionsRepository(CollectionsApiService());
    await collectionsRepository.addCollection(
      Collection(
        status: "UNPINNED",
        gameId: game.id!,
        userId: userId,
      ),
    );
    await refresh();
  }
}
