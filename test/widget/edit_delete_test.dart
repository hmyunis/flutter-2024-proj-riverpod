import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_test/riverpod_test.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/edit_delete.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/edit_game_modal.dart';
import 'package:video_game_catalogue_riverpod/providers/game_provider.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

void main() {
  testWidgets('EditDelete widget test', (WidgetTester tester) async {
    // Create mock providers using riverpod_test
    final mockUserSessionProvider =
        StateProvider.autoDispose((ref) => 'mockToken');
    final mockGameListProvider =
        AutoDisposeStateNotifierProvider<GameNotifier, List<Game>>(
      (ref) => GameNotifier.new(ref.watch(mockUserSessionProvider).state),
    );

    // Build the widget under test
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userSessionProvider.overrideWithValue(mockUserSessionProvider),
          gameListProvider.overrideWithValue(mockGameListProvider),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: EditDelete(
                game: Game(
              id: 1,
              title: 'Test Game',
              description: 'This is a test game',
              genre: 'Action',
              platform: 'PS4',
              publisher: 'Test Publisher',
              releaseDate: '2022-01-01',
              imageUrl: 'https://example.com/image.jpg',
            )),
          ),
        ),
      ),
    );

    // Verify that the Edit game detail button is rendered
    expect(find.text('Edit game detail'), findsOneWidget);

    // Verify that the Delete game button is rendered
    expect(find.text('Delete game'), findsOneWidget);

    // Tap the Edit game detail button and wait for the bottom sheet to appear
    await tester.tap(find.text('Edit game detail'));
    await tester.pumpAndSettle();

    // Verify that the EditGameBottomSheet widget is rendered
    expect(find.byType(EditGameBottomSheet), findsOneWidget);

    // Tap the Delete game button
    await tester.tap(find.text('Delete game'));
    await tester.pumpAndSettle();

    // Verify that the bottom sheet is dismissed after deletion
    expect(find.byType(EditGameBottomSheet), findsNothing);
  });
}
