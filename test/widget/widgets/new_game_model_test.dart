import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/new_game_modal.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

void main() {
  group('NewGameModal Widget Tests', () {
    final mockUserSessionProvider = UserSessionNotifier();
    testWidgets('Test NewGameModal Widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSessionProvider.overrideWith((ref) => mockUserSessionProvider),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: NewGameModal(),
            ),
          ),
        ),
      );

      expect(find.byType(NewGameModal), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(7));
      expect(find.text('Game Details'), findsOneWidget);

      final Finder titleField = find.byWidgetPredicate((widget) {
        if (widget is TextField) {
          final InputDecoration? decoration =
              widget.decoration as InputDecoration?;
          return decoration?.labelText == 'Title';
        }
        return false;
      });

      final Finder imageUrlField = find.byWidgetPredicate((widget) {
        if (widget is TextField) {
          final InputDecoration? decoration =
              widget.decoration as InputDecoration?;
          return decoration?.labelText == 'Image URL';
        }
        return false;
      });

      final Finder genreField = find.byWidgetPredicate((widget) {
        if (widget is TextField) {
          final InputDecoration? decoration =
              widget.decoration as InputDecoration?;
          return decoration?.labelText == 'Genre';
        }
        return false;
      });

      final Finder platformField = find.byWidgetPredicate((widget) {
        if (widget is TextField) {
          final InputDecoration? decoration =
              widget.decoration as InputDecoration?;
          return decoration?.labelText == 'Platform';
        }
        return false;
      });

      final Finder publisherField = find.byWidgetPredicate((widget) {
        if (widget is TextField) {
          final InputDecoration? decoration =
              widget.decoration as InputDecoration?;
          return decoration?.labelText == 'Publisher';
        }
        return false;
      });

      final Finder releaseDateField = find.byWidgetPredicate((widget) {
        if (widget is TextField) {
          final InputDecoration? decoration =
              widget.decoration as InputDecoration?;
          return decoration?.labelText == 'Release Date';
        }
        return false;
      });

      final Finder descriptionField = find.byWidgetPredicate((widget) {
        if (widget is TextField) {
          final InputDecoration? decoration =
              widget.decoration as InputDecoration?;
          return decoration?.labelText == 'Description';
        }
        return false;
      });

      expect(titleField, findsOneWidget);
      expect(imageUrlField, findsOneWidget);
      expect(genreField, findsOneWidget);
      expect(platformField, findsOneWidget);
      expect(publisherField, findsOneWidget);
      expect(releaseDateField, findsOneWidget);
      expect(descriptionField, findsOneWidget);

      await tester.enterText(titleField, 'Test Title');
      await tester.enterText(imageUrlField, 'https://example.com/image.jpg');
      await tester.enterText(genreField, 'Action');
      await tester.enterText(platformField, 'PC');
      await tester.enterText(publisherField, 'Example Publisher');
      await tester.enterText(releaseDateField, '2024-05-31');
      await tester.enterText(descriptionField, 'This is a test description.');

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('https://example.com/image.jpg'), findsOneWidget);
      expect(find.text('Action'), findsOneWidget);
      expect(find.text('PC'), findsOneWidget);
      expect(find.text('Example Publisher'), findsOneWidget);
      expect(find.text('2024-05-31'), findsOneWidget);
      expect(find.text('This is a test description.'), findsOneWidget);
    });
  });
}
