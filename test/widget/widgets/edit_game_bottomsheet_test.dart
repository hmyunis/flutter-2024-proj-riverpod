import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/edit_game_modal.dart';
import 'package:video_game_catalogue_riverpod/providers/game_provider.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';

class MockGameNotifier extends Mock implements GameNotifier {}

void main() {
  testWidgets('EditGameBottomSheet widget test', (WidgetTester tester) async {
    // Mock dependencies
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

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EditGameBottomSheet(game: game),
        ),
      ),
    );

    expect(find.text('Test Game'), findsOneWidget);
    expect(find.text('This is a test game'), findsOneWidget);
    expect(find.text('Action'), findsOneWidget);
    expect(find.text('Test Publisher'), findsOneWidget);
    expect(find.text('PS4'), findsOneWidget);
    expect(find.text('2022-01-01'), findsOneWidget);
    expect(find.text('https://example.com/image.jpg'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'Updated Title');
    await tester.enterText(find.byType(TextField).at(1), 'Updated Description');

    expect(find.text('Updated Title'), findsOneWidget);
    expect(find.text('Updated Description'), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.close), findsOneWidget);
  });
}
