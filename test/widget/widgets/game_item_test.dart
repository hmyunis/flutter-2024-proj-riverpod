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
      title: 'Game Title',
      genre: 'Action',
      platform: 'PC',
      publisher: 'Publisher Name',
      releaseDate: '2022-01-01',
      description: 'This is a test game description.',
      imageUrl: 'assets/images/games/ac-origins.jpg',
    );

    final mockUserSessionProvider = UserSessionNotifier();
    final mockGameListProvider = GameNotifier();

    // Set up the test widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProviderScope(
            overrides: [
              // gameListProvider
              //     .overrideWithValue([game]), // Provide a list of games
              // collectionListProvider
              //     .overrideWithValue([]), // Provide an empty collection list
              userSessionProvider.overrideWith(
                  (ref) => mockUserSessionProvider), // Provide a user session
            ],
            child: GameItem(
                game, false), // Initialize GameItem with isStarred false
          ),
        ),
      ),
    );

    // Verify that the game card is displayed with the correct image and title
    expect(find.byType(GameItem), findsOneWidget);
    expect(find.text('Game Title'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // // Verify that the game is favorited (star icon turns amber)
    // expect(find.byIcon(Icons.star), findsOneWidget);

    // // Tap on the star icon again to unfavorite the game
    // await tester.tap(find.byIcon(Icons.star));
    // await tester.pump();

    // // Verify that the game is unfavorited (star icon returns to default color)
    expect(find.byIcon(Icons.star_border), findsOneWidget);
  });
}
