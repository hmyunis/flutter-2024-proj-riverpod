import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/game_rating_bar.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

void main() {
  final mockUserSessionProvider = UserSessionNotifier();
  testWidgets('GameRatingBar widget should display rating bar and allow rating',
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

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProviderScope(
            overrides: [
              userSessionProvider
                  .overrideWith((ref) => mockUserSessionProvider),
            ],
            child: GameRatingBar(
              game: game,
              userLastRating: 0,
              averageRating: 3.5,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(GameRatingBar), findsOneWidget);
    expect(find.text('3.5'), findsOneWidget);
  });
}
