import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/game_item.dart';
import 'package:video_game_catalogue_riverpod/providers/collection_provider.dart';
import 'package:video_game_catalogue_riverpod/providers/game_provider.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

void main() {
  testWidgets(
      'GameItem widget should display game card and favorite/unfavorite game',
      (WidgetTester tester) async {
    // Mock game data
    final game = Game(
      title: 'Test Game',
      imageUrl: 'assets/images/test_game_image.jpg',
      // Add other necessary fields
    );

    // Set up the test widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProviderScope(
            overrides: [
              gameListProvider
                  .overrideWithValue([game]), // Provide a list of games
              collectionListProvider
                  .overrideWithValue([]), // Provide an empty collection list
              userSessionProvider.overrideWithValue(
                  UserSession(id: 'user_id')), // Provide a user session
            ],
            child: GameItem(
                game, false), // Initialize GameItem with isStarred false
          ),
        ),
      ),
    );

    // Verify that the game card is displayed with the correct image and title
    expect(find.byType(GameItem), findsOneWidget);
    expect(find.text('Test Game'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Tap on the star icon to favorite the game
    await tester.tap(find.byIcon(Icons.star_border));
    await tester.pump();

    // Verify that the game is favorited (star icon turns amber)
    expect(find.byIcon(Icons.star), findsOneWidget);

    // Tap on the star icon again to unfavorite the game
    await tester.tap(find.byIcon(Icons.star));
    await tester.pump();

    // Verify that the game is unfavorited (star icon returns to default color)
    expect(find.byIcon(Icons.star_border), findsOneWidget);
  });
}
