import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:video_game_catalogue_riverpod/models/user.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/role_mgt_pannel.dart';
import 'package:video_game_catalogue_riverpod/providers/user_provider.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';
import 'package:your_app_name/widgets/role_mgt_pannel.dart';
import 'package:your_app_name/models/user.dart';
import 'package:your_app_name/providers/user_provider.dart';
import 'package:your_app_name/providers/user_session_provider.dart';

// Mock UserListProvider
class MockUserListProvider extends Mock implements UserListProvider {}

// Mock UserSessionProvider
class MockUserSessionProvider extends Mock implements UserSessionProvider {}

void main() {
  group('RoleMgtPannel Widget Tests', () {
    testWidgets('Test RoleMgtPannel Widget', (WidgetTester tester) async {
      // Create a mock UserSessionProvider
      final mockUserSessionProvider = MockUserSessionProvider();

      // Create a mock UserListProvider
      final mockUserListProvider = MockUserListProvider();

      // Define test users
      final users = [
        User(id: 1, username: 'user1', role: 'user'),
        User(id: 2, username: 'user2', role: 'admin'),
        User(id: 3, username: 'user3', role: 'owner'),
      ];

      // Provide the mock UserSessionProvider and UserListProvider in the test widget tree
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSessionProvider.overrideWithValue(mockUserSessionProvider),
            userListProvider.overrideWithValue(mockUserListProvider),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: RoleMgtPannel(users: users),
            ),
          ),
        ),
      );

      // Verify that the user list is displayed correctly
      expect(find.byType(DataTable), findsOneWidget);
      expect(find.text('user1'), findsOneWidget);
      expect(find.text('user2'), findsOneWidget);
      expect(find.text('user3'), findsOneWidget);

      // Simulate changing user roles
      await tester.tap(find.byType(Switch).first);
      await tester.pump();

      // Verify that the role change is reflected in the UI
      expect(find.byType(Switch),
          findsNWidgets(3)); // Assuming there are 3 users in the list
      expect(find.byKey(const Key('save_changes_button')), findsOneWidget);

      // Simulate tapping the Save changes button
      await tester.tap(find.byKey(const Key('save_changes_button')));
      await tester.pump();

      // Verify that the saveChanges method is called
      verify(mockUserListProvider.notifier.promoteUser(any)).called(1);
      verify(mockUserListProvider.notifier.demoteUser(any))
          .called(0); // Assuming no demotion occurred in this test case
    });
  });
}
