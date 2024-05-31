import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/models/user.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/user_details_dialog.dart';

void main() {
  testWidgets('UserDetailsDialog displays user information',
      (WidgetTester tester) async {
    // Create a user object with sample data
    final user = User(
      id: 1,
      username: 'john_doe',
      email: 'john.doe@example.com',
      joinDate: '2022-01-01',
      role: 'admin',
    );

    // Build the UserDetailsDialog widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UserDetailsDialog(user),
        ),
      ),
    );

    // Verify that the dialog displays the user's information correctly
    expect(find.text("Account details"), findsOneWidget);
    expect(find.text('User ID: '), findsOneWidget);
    expect(find.text(user.id.toString()), findsOneWidget);
    expect(find.text('Username: '), findsOneWidget);
    expect(find.text(user.username), findsOneWidget);
    expect(find.text('Email: '), findsOneWidget);
    expect(find.text(user.email), findsOneWidget);
    expect(find.text('Join date: '), findsOneWidget);
    expect(find.text(user.joinDate), findsOneWidget);
    expect(find.text('Role: '), findsOneWidget);
    expect(find.text(user.role.toUpperCase()), findsOneWidget);
  });
}
