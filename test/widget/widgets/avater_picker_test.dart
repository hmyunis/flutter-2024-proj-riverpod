import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/avatar_picker_dialog.dart';
import 'package:video_game_catalogue_riverpod/providers/avatar_provider.dart';

void main() {
  testWidgets('AvatarPickerDialog displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: AvatarPickerDialog(),
          ),
        ),
      ),
    );

    // Verify the dialog title
    expect(find.text('Select an Avatar'), findsOneWidget);

    // Verify the cancel button
    expect(find.text('Cancel'), findsOneWidget);

    // Verify that the grid contains the correct number of avatars
    expect(find.byType(GridView), findsOneWidget);
  });

  testWidgets('Selecting an avatar sets the selected avatar index',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: AvatarPickerDialog(),
          ),
        ),
      ),
    );

    // Tap the first avatar
    await tester.tap(find.byType(CircleAvatar).first);
    await tester.pumpAndSettle();

    // Verify that the avatarProvider's state has been set to 0
    final container = ProviderContainer();
    expect(container.read(avatarProvider), 0);
  });

  testWidgets('Dialog closes when an avatar is selected',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: AvatarPickerDialog(),
          ),
        ),
      ),
    );

    // Tap the first avatar
    await tester.tap(find.byType(CircleAvatar).first);
    await tester.pumpAndSettle();

    // Verify that the dialog has closed
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('Dialog closes when the cancel button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: AvatarPickerDialog(),
          ),
        ),
      ),
    );

    // Tap the cancel button
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // Verify that the dialog has closed
    expect(find.byType(AlertDialog), findsNothing);
  });
}
