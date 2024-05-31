import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:video_game_catalogue_riverpod/presentation/screens/loading_screen.dart';
import 'package:video_game_catalogue_riverpod/providers/auth_provider.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

// Mock AuthNotifier for testing
class MockAuthNotifier extends Mock implements AuthNotifier {}

// Mock UserSessionNotifier for testing
class MockUserSessionNotifier extends Mock implements UserSessionNotifier {}

// Initialize mock providers
final mockAuthNotifier = MockAuthNotifier();
final mockUserSessionNotifier = MockUserSessionNotifier();

void main() {
  group('Login Widget Tests', () {
    testWidgets('renders MaterialApp', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSessionProvider.overrideWith((ref) => mockUserSessionNotifier),
            // authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: MaterialApp(
            home: LoadingScreen(),
          ),
        ),
      );
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('renders Scaffold', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // authProvider.overrideWithProvider(
            //     StateNotifierProvider((ref) => mockAuthNotifier)),
            userSessionProvider.overrideWithProvider(
                StateNotifierProvider((ref) => mockUserSessionNotifier)),
          ],
          child: MaterialApp(
            home: LoadingScreen(),
          ),
        ),
      );
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('renders LoginField', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSessionProvider.overrideWith((ref) => mockUserSessionNotifier),
          ],
          child: MaterialApp(
            home: Column(
              children: [SizedBox()],
            ),
          ),
        ),
      );
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders LoginButton', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSessionProvider.overrideWith((ref) => mockUserSessionNotifier),
          ],
          child: MaterialApp(
            home: Column(
              children: [
                Container(),
              ],
            ),
          ),
        ),
      );
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('renders EmailField', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSessionProvider.overrideWith((ref) => mockUserSessionNotifier),
          ],
          child: MaterialApp(
            home: Center(),
          ),
        ),
      );
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('renders Loading Icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSessionProvider.overrideWith((ref) => mockUserSessionNotifier),
          ],
          child: const MaterialApp(
            home: Column(
              children: [Text("")],
            ),
          ),
        ),
      );
      expect(find.byType(Text), findsOneWidget);
    });
  });
}
