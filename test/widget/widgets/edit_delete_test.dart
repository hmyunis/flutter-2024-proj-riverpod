import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/edit_delete.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

void main() {
  group('Edit Delete page Widget Tests', () {
    testWidgets('EditDelete widget test', (WidgetTester tester) async {
      final mockUserSessionProvider = UserSessionNotifier();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSessionProvider.overrideWith((ref) => mockUserSessionProvider),
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

      expect(find.text('Edit game detail'), findsOneWidget);

      expect(find.text('Delete game'), findsOneWidget);
    });
    testWidgets('renders MaterialApp', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold()));
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('renders Scaffold', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold()));
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('renders SizedBox', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SizedBox()));
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders Container', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Container()));
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('renders Center', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Center()));
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('renders Text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Text('')));
      expect(find.byType(Text), findsOneWidget);
    });
  });
}
