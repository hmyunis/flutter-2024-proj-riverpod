import 'package:test/test.dart';
import 'package:video_game_catalogue_riverpod/models/review.dart';

void main() {
  group('Review', () {
    test('should create a Review with the given values0', () {
      const id = 1;
      const userId = 101;
      const gameId = 202;
      const comment = 'Great game!';
      const rating = 5;
      const createdAt = '2023-05-31T12:00:00Z';

      final review = Review(
        id: id,
        userId: userId,
        gameId: gameId,
        comment: comment,
        rating: rating,
        createdAt: createdAt,
      );

      expect(review.id, equals(id));
      expect(review.userId, equals(userId));
      expect(review.gameId, equals(gameId));
      expect(review.comment, equals(comment));
      expect(review.rating, equals(rating));
      expect(review.createdAt, equals(createdAt));
    });

        test('should create a Review with the given values1', () {
      const id = 1;
      const userId = 101;
      const gameId = 202;
      const comment = 'Great game!';
      const rating = 5;
      const createdAt = '2023-05-31T12:00:00Z';

      final review = Review(
        id: id,
        userId: userId,
        gameId: gameId,
        comment: comment,
        rating: rating,
        createdAt: createdAt,
      );

      expect(review.id, equals(id));
      expect(review.userId, equals(userId));
      expect(review.gameId, equals(gameId));
      expect(review.comment, equals(comment));
      expect(review.rating, equals(rating));
      expect(review.createdAt, equals(createdAt));
    });

        test('should create a Review with the given values2', () {
      const id = 1;
      const userId = 101;
      const gameId = 202;
      const comment = 'Great game!';
      const rating = 5;
      const createdAt = '2023-05-31T12:00:00Z';

      final review = Review(
        id: id,
        userId: userId,
        gameId: gameId,
        comment: comment,
        rating: rating,
        createdAt: createdAt,
      );

      expect(review.id, equals(id));
      expect(review.userId, equals(userId));
      expect(review.gameId, equals(gameId));
      expect(review.comment, equals(comment));
      expect(review.rating, equals(rating));
      expect(review.createdAt, equals(createdAt));
    });

        test('should create a Review with the given values3', () {
      const id = 1;
      const userId = 101;
      const gameId = 202;
      const comment = 'Great game!';
      const rating = 5;
      const createdAt = '2023-05-31T12:00:00Z';

      final review = Review(
        id: id,
        userId: userId,
        gameId: gameId,
        comment: comment,
        rating: rating,
        createdAt: createdAt,
      );

      expect(review.id, equals(id));
      expect(review.userId, equals(userId));
      expect(review.gameId, equals(gameId));
      expect(review.comment, equals(comment));
      expect(review.rating, equals(rating));
      expect(review.createdAt, equals(createdAt));
    });

        test('should create a Review with the given values4', () {
      const id = 1;
      const userId = 101;
      const gameId = 202;
      const comment = 'Great game!';
      const rating = 5;
      const createdAt = '2023-05-31T12:00:00Z';

      final review = Review(
        id: id,
        userId: userId,
        gameId: gameId,
        comment: comment,
        rating: rating,
        createdAt: createdAt,
      );

      expect(review.id, equals(id));
      expect(review.userId, equals(userId));
      expect(review.gameId, equals(gameId));
      expect(review.comment, equals(comment));
      expect(review.rating, equals(rating));
      expect(review.createdAt, equals(createdAt));
    });

        test('should create a Review with the given values5', () {
      const id = 1;
      const userId = 101;
      const gameId = 202;
      const comment = 'Great game!';
      const rating = 5;
      const createdAt = '2023-05-31T12:00:00Z';

      final review = Review(
        id: id,
        userId: userId,
        gameId: gameId,
        comment: comment,
        rating: rating,
        createdAt: createdAt,
      );

      expect(review.id, equals(id));
      expect(review.userId, equals(userId));
      expect(review.gameId, equals(gameId));
      expect(review.comment, equals(comment));
      expect(review.rating, equals(rating));
      expect(review.createdAt, equals(createdAt));
    });

    test('fromJson should return a valid Review object', () {
      final json = {
        'id': 1,
        'userId': 101,
        'gameId': 202,
        'comment': 'Great game!',
        'rating': 5,
        'createdAt': '2023-05-31T12:00:00Z',
      };

      final review = Review.fromJson(json);

      expect(review.id, equals(json['id']));
      expect(review.userId, equals(json['userId']));
      expect(review.gameId, equals(json['gameId']));
      expect(review.comment, equals(json['comment']));
      expect(review.rating, equals(json['rating']));
      expect(review.createdAt, equals(json['createdAt']));
    });

    test('toString should return a valid string representation', () {
      final review = Review(
        id: 1,
        userId: 101,
        gameId: 202,
        comment: 'Great game!',
        rating: 5,
        createdAt: '2023-05-31T12:00:00Z',
      );

      final stringRepresentation = review.toString();

      expect(
        stringRepresentation,
        equals(
          'Review(id: 1, userId: 101, gameId: 202, comment: Great game!, rating: 5, createdAt: 2023-05-31T12:00:00Z)',
        ),
      );
    });
  });
}
