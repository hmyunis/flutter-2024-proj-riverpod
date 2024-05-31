import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_game_catalogue_riverpod/models/user.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/role_mgt_pannel.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

void main() {
  group('RoleMgtPannel Widget Tests', () {
    testWidgets('Test RoleMgtPannel Widget', (WidgetTester tester) async {
      final mockUserSessionProvider = UserSessionNotifier();

      final users = [
        User(
          id: 1,
          username: 'estif',
          email: 'john.doe@example.com',
          joinDate: '1980-03-04',
          role: 'user',
        ),
        User(
          id: 2,
          username: 'moti',
          email: 'john.doe@example.com',
          joinDate: '2000-12-12',
          role: 'admin',
        ),
        User(
          id: 3,
          username: 'hamdi',
          email: 'john.doe@example.com',
          joinDate: '1000-01-01',
          role: 'owner',
        ),
      ];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSessionProvider.overrideWith((ref) => mockUserSessionProvider),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: RoleMgtPannel(users: users),
            ),
          ),
        ),
      );

      expect(find.byType(DataTable), findsOneWidget);
      expect(find.text('estif'), findsOneWidget);
      expect(find.text('moti'), findsOneWidget);
      expect(find.text('hamdi'), findsOneWidget);
      expect(find.text('ID'), findsOneWidget);
      expect(find.text('USERNAME'), findsOneWidget);
      expect(find.text('ADMIN'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
      expect(find.text('Save changes'), findsOneWidget);

      await tester.tap(find.text("Close"));
      await tester.pump();

      expect(find.byType(DataTable), findsOneWidget);
      expect(find.text('estif'), findsOneWidget);
      expect(find.text('moti'), findsOneWidget);
      expect(find.text('hamdi'), findsOneWidget);
      expect(find.text('ID'), findsOneWidget);
      expect(find.text('USERNAME'), findsOneWidget);
      expect(find.text('ADMIN'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
      expect(find.text('Save changes'), findsOneWidget);

      await tester.tap(find.byType(Switch).first);
      await tester.pump();
    });
  });
}
