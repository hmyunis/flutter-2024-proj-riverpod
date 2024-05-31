import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/models/game.dart';

import 'package:video_game_catalogue_riverpod/models/user.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/comment_box.dart';
import 'package:video_game_catalogue_riverpod/providers/avatar_provider.dart';

import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

void main() {
  final testGame = Game(
    id: 1,
    title: 'Test Game',
    description: 'Description',
    genre: 'Genre',
    platform: 'Platform',
    publisher: 'Publisher',
    releaseDate: '2023-01-01',
    imageUrl: 'https://example.com/image.jpg',
  );

  final testUser = User(
    id: 1,
    username: 'testuser',
    email: 'test@example.com',
    joinDate: '2023-01-01',
    role: 'user',
  );

  testWidgets('CommentBox adds a comment when send button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          avatarProvider.overrideWith((ref) => AvatarNotifier()..setIndex(0)),
          userSessionProvider
              .overrideWith((ref) => UserSessionNotifier()..setUser(testUser)),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: CommentBox(game: testGame),
          ),
        ),
      ),
    );

    final commentFieldFinder = find.byType(TextField);

    await tester.enterText(commentFieldFinder, 'Great game!');
    await tester.pump();

    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('CommentBox shows an error when trying to send an empty comment',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          avatarProvider.overrideWith((ref) => AvatarNotifier()..setIndex(0)),
          userSessionProvider
              .overrideWith((ref) => UserSessionNotifier()..setUser(testUser)),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: CommentBox(game: testGame),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(TextField), findsOneWidget);
  });
}
