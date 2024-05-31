import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/new_game_modal.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

// Mock UserSessionProvider
class MockUserSessionProvider extends Mock implements UserSessionProvider {}

void main() {
  group('NewGameModal Widget Tests', () {
    testWidgets('Test NewGameModal Widget', (WidgetTester tester) async {
      // Create a mock UserSessionProvider
      final mockUserSessionProvider = MockUserSessionProvider();

      // Provide the mock UserSessionProvider in the test widget tree
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSessionProvider.overrideWithValue(mockUserSessionProvider),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: NewGameModal(),
            ),
          ),
        ),
      );

      // Verify that the title text field is initially empty
      expect(find.byKey(const Key('title_field')), findsOneWidget);
      expect(find.text(''), findsOneWidget);

      // Enter text into the title text field
      await tester.enterText(
          find.byKey(const Key('title_field')), 'Test Game Title');

      // Verify that the entered text is correct
      expect(find.text('Test Game Title'), findsOneWidget);

      // Tap the Create game button
      await tester.tap(find.byKey(const Key('create_game_button')));

      // Wait for the build method to complete
      await tester.pump();

      // Verify that the game creation process is initiated by checking if the game is added to the provider
      verify(mockGameListProvider(any).notifier.createGame(Game(
            title: 'Test Game Title',
            // Add other necessary properties here based on your Game model
          ))).called(1);
    });
  });
}
