import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/favorite_item.dart';

void main() {
  testWidgets('FavoriteItem widget test', (WidgetTester tester) async {
    final testGame = Game(
      id: 1,
      title: 'Test Game',
      imageUrl: 'assets/images/games/ac-origins.jpg',
      description: 'This is a test game description.',
      genre: 'Adventure',
      platform: 'PC',
      publisher: 'Test Publisher',
      releaseDate: '2022-01-01',
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: FavoriteItem(
              game: testGame,
              tileColor: Colors.blueGrey[800],
              isNotPinned: true,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Test Game'), findsOneWidget);

    expect(find.text('This is a test game description.'), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
  });
}
