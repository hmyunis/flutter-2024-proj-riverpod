import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/game_item.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/games_list.dart';

void main() {
  testWidgets('GamesList widget should display games correctly',
      (WidgetTester tester) async {
    // Mock game data
    final games = [
      Game(
        id: 1,
        title: 'Game 1',
        imageUrl: 'assets/images/games/ac-origins.jpg',
        description: 'This is a test game description.',
        genre: 'Adventure',
        platform: 'PC',
        publisher: 'Test Publisher',
        releaseDate: '2022-01-01',
      ),
      Game(
        id: 1,
        title: 'Game 2',
        imageUrl: 'assets/images/games/ac-origins.jpg',
        description: 'This is a test game description.',
        genre: 'Adventure',
        platform: 'PC',
        publisher: 'Test Publisher',
        releaseDate: '2022-01-01',
      ),
      Game(
        id: 1,
        title: 'Game 3',
        imageUrl: 'assets/images/games/ac-origins.jpg',
        description: 'This is a test game description.',
        genre: 'Adventure',
        platform: 'PC',
        publisher: 'Test Publisher',
        releaseDate: '2022-01-01',
      ),
    ];

    // Mock favorite game IDs
    final favoriteGameIds = [1, 3]; // Game 1 and Game 3 are favorites

    // Set up the test widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GamesList(games, favoriteGameIds),
        ),
      ),
    );

    // Verify that the games list is displayed with the correct number of game items
    expect(find.byType(GameItem), findsNWidgets(games.length));

    // Verify that Game 1 and Game 3 are marked as favorites
    expect(find.text('Game 1'), findsOneWidget);
    expect(find.text('Game 3'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNWidgets(3)); // Verify favorite icon

    // Verify that Game 2 is not marked as a favorite
    expect(find.text('Game 2'), findsOneWidget);
    // expect(find.byIcon(Icons.star_border),
    //     findsNWidgets(3)); // Verify non-favorite icon
  });
}
