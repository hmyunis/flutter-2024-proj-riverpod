import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/game_item.dart';
import 'package:video_game_catalogue_riverpod/providers/game_provider.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

void main() {
  testWidgets(
      'GameItem widget should display game card and favorite/unfavorite game',
      (WidgetTester tester) async {
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

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProviderScope(
            overrides: [
              userSessionProvider
                  .overrideWith((ref) => mockUserSessionProvider),
            ],
            child: GameItem(game, false),
          ),
        ),
      ),
    );

    expect(find.byType(GameItem), findsOneWidget);
    expect(find.text('Game Title'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    expect(find.byIcon(Icons.star_border), findsOneWidget);
  });
}
