import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/game_item.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/games_list.dart';

void main() {
  testWidgets('GamesList widget should display games correctly',
      (WidgetTester tester) async {
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

    final favoriteGameIds = [1, 3];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GamesList(games, favoriteGameIds),
        ),
      ),
    );

    expect(find.byType(GameItem), findsNWidgets(games.length));

    expect(find.text('Game 1'), findsOneWidget);
    expect(find.text('Game 3'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNWidgets(3));

    expect(find.text('Game 2'), findsOneWidget);
  });
}
