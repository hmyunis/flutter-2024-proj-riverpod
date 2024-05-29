import 'dart:convert';

import '../../models/collection.dart';
import '../services/collections_api_service.dart';

class CollectionsRepository {
  final CollectionsApiService _collectionsApiService;
  CollectionsRepository(this._collectionsApiService);

  Future<List<Collection>> getCollections() async {
    final response = await _collectionsApiService.getCollections();
    final collections = jsonDecode(response);
    final allCollections = <Collection>[];
    for (final collection in collections) {
      allCollections.add(Collection.fromJson(collection));
    }
    return allCollections;
  }

  Future<Collection> getCollection(int collectionId) async {
    final response =
        await _collectionsApiService.getCollection(collectionId.toString());
    final collection = jsonDecode(response);
    return Collection.fromJson(collection);
  }

  Future<List<int>> getGameIdsByStatus(int userId, String status) async {
    final response = await _collectionsApiService.getGameIdsByStatus(
        userId.toString(), status);
    final gameIds = jsonDecode(response);
    final allGameIds = <int>[];
    for (final gameId in gameIds) {
      allGameIds.add(gameId);
    }
    return allGameIds;
  }

  Future<Collection> addCollection(Collection collection) async {
    final response = await _collectionsApiService.addCollection({
      'userId': collection.userId,
      'status': collection.status,
      'gameId': collection.gameId,
    });
    final newCollection = jsonDecode(response);
    return Collection.fromJson(newCollection);
  }

  Future<void> deleteCollection(int collectionId) async {
    await _collectionsApiService.deleteCollection(collectionId.toString());
  }

  Future<Collection> updateCollection(
      int collectionId, Collection collection) async {
    final response = await _collectionsApiService
        .updateCollection(collectionId.toString(), {
      'userId': collection.userId,
      'status': collection.status,
      'gameId': collection.gameId,
    });
    final updatedCollection = jsonDecode(response);
    return Collection.fromJson(updatedCollection);
  }
}
