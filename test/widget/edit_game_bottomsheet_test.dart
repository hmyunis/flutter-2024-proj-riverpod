import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/edit_game_modal.dart';
import 'package:video_game_catalogue_riverpod/providers/game_provider.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

// Create a mock class for GameNotifier
class MockGameNotifier extends Mock implements GameNotifier {}

void main() {
  testWidgets('EditGameBottomSheet widget test', (WidgetTester tester) async {
    // Mock dependencies
    final mockGameNotifier = MockGameNotifier();
    final game = Game(
      id: 1,
      title: 'Test Game',
      imageUrl: 'https://example.com/image.jpg',
      genre: 'Action',
      description: 'This is a test game',
      publisher: 'Test Publisher',
      platform: 'PS4',
      releaseDate: '2022-01-01',
    );

    // Build the EditGameBottomSheet widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EditGameBottomSheet(game: game),
        ),
      ),
    );

    // Verify that the initial values are set correctly
    expect(find.text('Test Game'), findsOneWidget);
    expect(find.text('This is a test game'), findsOneWidget);
    expect(find.text('Action'), findsOneWidget);
    expect(find.text('Test Publisher'), findsOneWidget);
    expect(find.text('PS4'), findsOneWidget);
    expect(find.text('2022-01-01'), findsOneWidget);
    expect(find.text('https://example.com/image.jpg'), findsOneWidget);

    // Simulate user input
    await tester.enterText(find.byType(TextField).first, 'Updated Title');
    await tester.enterText(find.byType(TextField).at(1), 'Updated Description');

    // Tap the Save changes button
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // Verify that updateGame was called with the correct arguments
    verify(mockGameNotifier.updateGame(Game(
      id: 1,
      title: 'Updated Title',
      imageUrl: 'https://example.com/image.jpg',
      genre: 'Action',
      description: 'Updated Description',
      publisher: 'Test Publisher',
      platform: 'PS4',
      releaseDate: '2022-01-01',
    ))).called(1);

    // Verify that Navigator.pop(context) was called
    expect(find.byIcon(Icons.close), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // Verify that the bottom sheet is dismissed
    expect(find.byType(EditGameBottomSheet), findsNothing);
  });
}
