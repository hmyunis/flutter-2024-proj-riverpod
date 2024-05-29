import 'dart:convert';

import '../../models/game.dart';

import '../services/games_api_service.dart';

class GamesRepository {
  final GamesApiService _gamesApiService;

  GamesRepository(this._gamesApiService);

  Future<List<Game>> getGames() async {
    final response = await _gamesApiService.getGames();
    final games = jsonDecode(response);
    final allGames = <Game>[];
    for (final game in games){
      allGames.add(Game.fromJson(game));
    }
    return allGames;
  }

  Future<Game> getGame(int id) async {
    final response = await _gamesApiService.getGameById(id.toString());
    final game = jsonDecode(response);
    return Game.fromJson(game);
  }

  Future getGamesByGenre(String genre) {
    return _gamesApiService.getGamesByGenre(genre);
  }

  Future<void> createGame(Game game, String token) async {
    await _gamesApiService.addGame({
      'title': game.title,
      'description': game.description,
      'genre': game.genre,
      'platform': game.platform,
      'publisher': game.publisher,
      'releaseDate': game.releaseDate,
      'imageUrl': game.imageUrl,
    }, token);
  }

  Future<void> updateGame(Game game, String token) async {
    await _gamesApiService.updateGame({
      'id': game.id,
      'title': game.title,
      'description': game.description,
      'genre': game.genre,
      'platform': game.platform,
      'publisher': game.publisher,
      'releaseDate': game.releaseDate,
      'imageUrl': game.imageUrl,
    }, token);
  }

  Future<void> deleteGame(int id, String token) async {
    await _gamesApiService.deleteGame(id.toString(), token);
  }
}
