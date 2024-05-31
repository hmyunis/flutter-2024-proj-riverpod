import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/screens/game_detail_page.dart';

import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

void main() {
  // Build the widget under test
  testWidgets('GameInfo widget as used in Games Detail Page',
      (WidgetTester tester) async {
    final mockUserSessionProvider = UserSessionNotifier();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userSessionProvider.overrideWith((ref) => mockUserSessionProvider),
        ],
        child: MaterialApp(
          home: GameDetailPage(
            game: Game(
              title: 'Game Title',
              genre: 'Action',
              platform: 'PC',
              publisher: 'Publisher Name',
              releaseDate: '2022-01-01',
              description: 'This is a test game description.',
              imageUrl: 'assets/images/games/ac-origins.jpg',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Game Title'), findsNWidgets(2));
    expect(find.text('Action'), findsOneWidget);
    expect(find.text('PC'), findsOneWidget);
    expect(find.text('Publisher Name'), findsOneWidget);
    expect(find.text('2022-01-01'), findsOneWidget);
    expect(find.text('This is a test game description.'), findsOneWidget);
  });
}
