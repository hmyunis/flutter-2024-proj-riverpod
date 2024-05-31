import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/comment_box.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/comment_section.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/game_rating_bar.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/game_rating_comments.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';
import 'package:video_game_catalogue_riverpod/providers/review_provider.dart';

// Mock implementation of UserSessionProvider
class MockUserSessionProvider extends Mock implements UserSessionProvider {}

void main() {
  testWidgets(
      'GameRatingComments widget should display correctly based on state',
      (WidgetTester tester) async {
    // Mock game data
    final game = Game(
      id: 1,
      // Add other necessary fields
    );

    // Mock user session provider
    final mockUserSessionProvider = MockUserSessionProvider();

    // Set up the test widget
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userSessionProvider.overrideWithProvider(
            Provider((ref) => mockUserSessionProvider),
          ),
          gameRatingCommentsProvider.overrideWithValue(
            AsyncValue.data([
              [], // Reviews list
              {}, // User ID to username map
              3, // User's last rating
              4.5, // Average rating
              10, // Number of reviews
            ]),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: GameRatingComments(game: game),
          ),
        ),
      ),
    );

    // Verify that the widget displays the rating bar, comment box, and comment section
    expect(find.byType(GameRatingBar), findsOneWidget);
    expect(find.byType(CommentBox), findsOneWidget);
    expect(find.byType(CommentSection), findsOneWidget);
    expect(find.text('Comments'), findsOneWidget);
    expect(find.text('Error, please try again'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
