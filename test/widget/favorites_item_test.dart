import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/screens/game_detail_page.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/favorite_item.dart';

void main() {
  testWidgets('FavoriteItem widget test', (WidgetTester tester) async {
    // Create a test game
    final testGame = Game(
      id: 1,
      title: 'Test Game',
      imageUrl: 'assets/images/test_game.jpg',
      description: 'This is a test game description.',
      genre: 'Adventure',
      platform: 'PC',
      publisher: 'Test Publisher',
      releaseDate: '2022-01-01',
    );

    // Build the FavoriteItem widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FavoriteItem(
            game: testGame,
            tileColor: Colors.blueGrey[800],
            isNotPinned: true,
          ),
        ),
      ),
    );

    // Verify that the FavoriteItem widget displays the correct information
    expect(find.text('Test Game'), findsOneWidget);
    expect(find.text('This is a test game description.'), findsOneWidget);
    expect(find.text('Adventure'), findsOneWidget);
    expect(find.text('PC'), findsOneWidget);
    expect(find.text('Test Publisher'), findsOneWidget);
    expect(find.text('2022-01-01'), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);

    // Tap the ListTile to navigate to GameDetailPage
    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();

    // Verify that GameDetailPage is pushed onto the navigator stack
    expect(find.byType(GameDetailPage), findsOneWidget);

    // Verify that the GameDetailPage displays the correct game information
    expect(find.text('Test Game'), findsOneWidget);
    expect(find.text('This is a test game description.'), findsOneWidget);
    expect(find.text('Adventure'), findsOneWidget);
    expect(find.text('PC'), findsOneWidget);
    expect(find.text('Test Publisher'), findsOneWidget);
    expect(find.text('2022-01-01'), findsOneWidget);
  });
}
