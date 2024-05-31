import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/game_rating_bar.dart';
import 'package:video_game_catalogue_riverpod/providers/review_provider.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

void main() {
  testWidgets('GameRatingBar widget should display rating bar and allow rating',
      (WidgetTester tester) async {
    // Mock game data
    final game = Game(
      id: 1,
      // Add other necessary fields
    );

    // Set up the test widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProviderScope(
            overrides: [
              gameListProvider
                  .overrideWithValue([]), // Provide an empty game list
              reviewListProvider
                  .overrideWithValue([]), // Provide an empty review list
              userSessionProvider.overrideWithValue(
                  UserSession(id: 'user_id')), // Provide a user session
            ],
            child: GameRatingBar(
              game: game,
              userLastRating: 0,
              averageRating: 3.5, // Provide a mock average rating
            ),
          ),
        ),
      ),
    );

    // Verify that the rating bar is displayed with the correct average rating
    expect(find.byType(GameRatingBar), findsOneWidget);
    expect(find.text('3.5'), findsOneWidget);

    // Tap on a star to rate the game
    await tester.tap(find
        .byIcon(Icons.star_border)
        .at(2)); // Tap on the third star (index 2)
    await tester.pump();

    // Verify that the star is filled after rating
    expect(find.byIcon(Icons.star),
        findsNWidgets(3)); // Verify that 3 stars are filled
  });
}
