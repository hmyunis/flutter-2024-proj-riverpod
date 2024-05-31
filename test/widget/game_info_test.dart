import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/edit_delete.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/game_info.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

void main() {
  testWidgets('GameInfo widget should display game information',
      (WidgetTester tester) async {
    // Wrap the widget in ProviderScope for testing with Riverpod
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userSessionProvider.overrideWithValue(
            UserSession(role: 'owner'), // Set the user's role
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: GameInfo(
              game: Game(
                title: 'Game Title',
                genre: 'Action',
                platform: 'PC',
                publisher: 'Publisher Name',
                releaseDate: '2022-01-01',
                description: 'This is a test game description.',
                imageUrl: 'assets/images/game_image.jpg',
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

    // Verify that the EditDelete widget is shown for an owner
    expect(find.byType(EditDelete), findsOneWidget);

    // Verify that a SizedBox is shown for a non-owner user
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userSessionProvider.overrideWithValue(
            UserSession(role: 'user'), // Set a different user role
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: GameInfo(
              game: Game(
                title: 'Game Title',
                genre: 'Action',
                platform: 'PC',
                publisher: 'Publisher Name',
                releaseDate: '2022-01-01',
                description: 'This is a test game description.',
                imageUrl: 'assets/images/game_image.jpg',
              ),
            ),
          ),
        ),
      ),
    );

    // Verify that the EditDelete widget is not shown for a non-owner user
    expect(find.byType(EditDelete), findsNothing);
    expect(find.byType(SizedBox), findsOneWidget);
  });
}
