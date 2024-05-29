import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/collections_repository.dart';
import '../data/repositories/games_repository.dart';
import '../data/repositories/users_repository.dart';
import '../data/services/collections_api_service.dart';
import '../data/services/games_api_service.dart';
import '../data/services/users_api_service.dart';
import '../models/collection.dart';
import '../models/game.dart';

final gameListProvider = AsyncNotifierProvider.autoDispose
    .family<GameNotifier, List, String>(GameNotifier.new);

class GameNotifier extends AutoDisposeFamilyAsyncNotifier<List, String> {
  String _token = "";

  @override
  Future<List> build(String arg) async {
    _token = arg;
    final GamesRepository gamesRepository = GamesRepository(GamesApiService());
    final CollectionsRepository collectionsRepository =
        CollectionsRepository(CollectionsApiService());

    final List<Collection> collections =
          await collectionsRepository.getCollections();
      final UsersRepository usersRepository =
          UsersRepository(UsersApiService());
      final user = await usersRepository.getCurrentUser(arg);
      final List<Collection> usersCollection = collections
          .where((collection) => collection.userId == user.id)
          .toList();
      final List<int> userFavoriteGameIds = <int>[];
      for (final collection in usersCollection) {
        userFavoriteGameIds.add(collection.gameId);
      }

      final games = await gamesRepository.getGames();
      return [[...games], [...userFavoriteGameIds]];
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> createGame(Game game) async {
    final GamesRepository gamesRepository = GamesRepository(GamesApiService());
    await gamesRepository.createGame(game, _token);
    await refresh();
  }

  Future<void> updateGame(Game game) async {
    final GamesRepository gamesRepository = GamesRepository(GamesApiService());
    await gamesRepository.updateGame(game, _token);
    await refresh();
  }

  Future<void> deleteGame(Game game) async {
    final GamesRepository gamesRepository = GamesRepository(GamesApiService());
    await gamesRepository.deleteGame(game.id!, _token);
    await refresh();
  }
}
