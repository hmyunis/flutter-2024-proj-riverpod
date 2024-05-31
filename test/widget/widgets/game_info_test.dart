import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/screens/game_detail_page.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/edit_delete.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/game_info.dart';
import 'package:video_game_catalogue_riverpod/providers/game_provider.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

void main() {
  testWidgets('GameInfo widget should display game information',
      (WidgetTester tester) async {
    // Wrap the widget in ProviderScope for testing with Riverpod
    final mockUserSessionProvider = UserSessionNotifier();
    final mockGameListProvider = GameNotifier();

    // Build the widget under test
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userSessionProvider.overrideWith((ref) => mockUserSessionProvider),
          // gameListProvider.overrideWith((ref) => mockGameListProvider),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: GameInfo(
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
        ),
      ),
    );

    // Verify that the game information is displayed correctly
    expect(find.text('Game Title'), findsOneWidget);
    expect(find.text('Action'), findsOneWidget);
    expect(find.text('PC'), findsOneWidget);
    expect(find.text('Publisher Name'), findsOneWidget);
    expect(find.text('2022-01-01'), findsOneWidget);
    expect(find.text('This is a test game description.'), findsOneWidget);
  });
}
