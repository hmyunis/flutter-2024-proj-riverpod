import 'package:test/test.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';

void main() {
  group('Game', () {
    test('should create a Game with the given values', () {
      const id = 1;
      const title = 'The Legend of Zelda';
      const description = 'An action-adventure game.';
      const genre = 'Action-Adventure';
      const platform = 'Nintendo Switch';
      const publisher = 'Nintendo';
      const releaseDate = '2017-03-03';
      const imageUrl = 'https://example.com/zelda.jpg';

      final game = Game(
        id: id,
        title: title,
        description: description,
        genre: genre,
        platform: platform,
        publisher: publisher,
        releaseDate: releaseDate,
        imageUrl: imageUrl,
      );

      expect(game.id, equals(id));
      expect(game.title, equals(title));
      expect(game.description, equals(description));
      expect(game.genre, equals(genre));
      expect(game.platform, equals(platform));
      expect(game.publisher, equals(publisher));
      expect(game.releaseDate, equals(releaseDate));
      expect(game.imageUrl, equals(imageUrl));
    });

    test('fromJson should return a valid Game object', () {
      final json = {
        'id': 1,
        'title': 'The Legend of Zelda',
        'description': 'An action-adventure game.',
        'genre': 'Action-Adventure',
        'platform': 'Nintendo Switch',
        'publisher': 'Nintendo',
        'releaseDate': '2017-03-03',
        'imageUrl': 'https://example.com/zelda.jpg',
      };

      final game = Game.fromJson(json);

      expect(game.id, equals(json['id']));
      expect(game.title, equals(json['title']));
      expect(game.description, equals(json['description']));
      expect(game.genre, equals(json['genre']));
      expect(game.platform, equals(json['platform']));
      expect(game.publisher, equals(json['publisher']));
      expect(game.releaseDate, equals(json['releaseDate']));
      expect(game.imageUrl, equals(json['imageUrl']));
    });

    test('toJson should return a valid JSON map', () {
      final game = Game(
        id: 1,
        title: 'The Legend of Zelda',
        description: 'An action-adventure game.',
        genre: 'Action-Adventure',
        platform: 'Nintendo Switch',
        publisher: 'Nintendo',
        releaseDate: '2017-03-03',
        imageUrl: 'https://example.com/zelda.jpg',
      );

      final json = game.toJson();

      expect(json['id'], equals(game.id));
      expect(json['title'], equals(game.title));
      expect(json['description'], equals(game.description));
      expect(json['genre'], equals(game.genre));
      expect(json['platform'], equals(game.platform));
      expect(json['publisher'], equals(game.publisher));
      expect(json['releaseDate'], equals(game.releaseDate));
      expect(json['imageUrl'], equals(game.imageUrl));
    });

    test('should return true for equal Game objects', () {
      final game1 = Game(
        id: 1,
        title: 'The Legend of Zelda',
        description: 'An action-adventure game.',
        genre: 'Action-Adventure',
        platform: 'Nintendo Switch',
        publisher: 'Nintendo',
        releaseDate: '2017-03-03',
        imageUrl: 'https://example.com/zelda.jpg',
      );

      final game2 = Game(
        id: 1,
        title: 'The Legend of Zelda',
        description: 'An action-adventure game.',
        genre: 'Action-Adventure',
        platform: 'Nintendo Switch',
        publisher: 'Nintendo',
        releaseDate: '2017-03-03',
        imageUrl: 'https://example.com/zelda.jpg',
      );

      expect(game1, equals(game2));
      expect(game1.hashCode, equals(game2.hashCode));
    });

    test('should return false for non-equal Game objects', () {
      final game1 = Game(
        id: 1,
        title: 'The Legend of Zelda',
        description: 'An action-adventure game.',
        genre: 'Action-Adventure',
        platform: 'Nintendo Switch',
        publisher: 'Nintendo',
        releaseDate: '2017-03-03',
        imageUrl: 'https://example.com/zelda.jpg',
      );

      final game2 = Game(
        id: 2,
        title: 'Super Mario Odyssey',
        description: 'A platform game.',
        genre: 'Platform',
        platform: 'Nintendo Switch',
        publisher: 'Nintendo',
        releaseDate: '2017-10-27',
        imageUrl: 'https://example.com/mario.jpg',
      );

      expect(game1, isNot(equals(game2)));
      expect(game1.hashCode, isNot(equals(game2.hashCode)));
    });

    test('toString should return a valid string representation', () {
      final game = Game(
        id: 1,
        title: 'The Legend of Zelda',
        description: 'An action-adventure game.',
        genre: 'Action-Adventure',
        platform: 'Nintendo Switch',
        publisher: 'Nintendo',
        releaseDate: '2017-03-03',
        imageUrl: 'https://example.com/zelda.jpg',
      );

      final stringRepresentation = game.toString();

      expect(
        stringRepresentation,
        equals(
          'Game{id: 1, title: The Legend of Zelda, description: An action-adventure game., genre: Action-Adventure, platform: Nintendo Switch, publisher: Nintendo, releaseDate: 2017-03-03, imageUrl: https://example.com/zelda.jpg}',
        ),
      );
    });
  });
}
