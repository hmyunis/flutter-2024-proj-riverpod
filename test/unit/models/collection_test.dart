import 'package:test/test.dart';
import 'package:video_game_catalogue_riverpod/models/collection.dart';

void main() {
  group('Collection', () {
    test('should create a Collection with the given values', () {
      const id = 1;
      const status = 'completed';
      const gameId = 101;
      const userId = 202;

      final collection = Collection(
        id: id,
        status: status,
        gameId: gameId,
        userId: userId,
      );

      expect(collection.id, equals(id));
      expect(collection.status, equals(status));
      expect(collection.gameId, equals(gameId));
      expect(collection.userId, equals(userId));
    });

    test('fromJson should return a valid Collection object', () {
      final json = {
        'id': 1,
        'status': 'completed',
        'gameId': 101,
        'userId': 202,
      };

      final collection = Collection.fromJson(json);

      expect(collection.id, equals(json['id']));
      expect(collection.status, equals(json['status']));
      expect(collection.gameId, equals(json['gameId']));
      expect(collection.userId, equals(json['userId']));
    });

    test('toJson should return a valid JSON map', () {
      final collection = Collection(
        id: 1,
        status: 'completed',
        gameId: 101,
        userId: 202,
      );

      final json = collection.toJson();

      expect(json['id'], equals(collection.id));
      expect(json['status'], equals(collection.status));
      expect(json['gameId'], equals(collection.gameId));
      expect(json['userId'], equals(collection.userId));
    });

    test('should return true for equal Collection objects', () {
      final collection1 = Collection(
        id: 1,
        status: 'completed',
        gameId: 101,
        userId: 202,
      );

      final collection2 = Collection(
        id: 1,
        status: 'completed',
        gameId: 101,
        userId: 202,
      );

      expect(collection1, equals(collection2));
      expect(collection1.hashCode, equals(collection2.hashCode));
    });

    test('should return false for non-equal Collection objects', () {
      final collection1 = Collection(
        id: 1,
        status: 'completed',
        gameId: 101,
        userId: 202,
      );

      final collection2 = Collection(
        id: 2,
        status: 'in-progress',
        gameId: 102,
        userId: 203,
      );

      expect(collection1, isNot(equals(collection2)));
      expect(collection1.hashCode, isNot(equals(collection2.hashCode)));
    });

    test('toString should return a valid string representation', () {
      final collection = Collection(
        id: 1,
        status: 'completed',
        gameId: 101,
        userId: 202,
      );

      final stringRepresentation = collection.toString();

      expect(stringRepresentation, equals('Collection{id: 1, status: completed, gameId: 101, userId: 202}'));
    });
  });
}
