import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:video_game_catalogue_riverpod/models/review.dart';
import 'package:video_game_catalogue_riverpod/models/user.dart';
import 'package:video_game_catalogue_riverpod/presentation/widgets/comment_section.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

import '../../mock/mock.mocks.dart';

void main() {
  final mockUserSessionNotifier = MockUserSessionNotifier();

  setUp(() {
    when(mockUserSessionNotifier.state).thenReturn(
      User(
          id: 1,
          username: 'testuser',
          email: 'test@example.com',
          joinDate: '',
          role: ''),
    );
  });

  final List<Review> reviews = [
    Review(id: 1, userId: 1, gameId: 1, comment: 'Great game!', rating: 5),
    Review(id: 2, userId: 2, gameId: 1, comment: 'Not bad', rating: 3),
  ];
  final Map<int, String> userIdToUsernameMap = {
    1: 'testuser',
    2: 'anotheruser',
  };

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        userSessionProvider.overrideWith((ref) => mockUserSessionNotifier),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: CommentSection(
            reviews: reviews,
            userIdToUsernameMap: userIdToUsernameMap,
            numReviews: 0,
          ),
        ),
      ),
    );
  }

  testWidgets('CommentSection displays reviews', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(Dismissible), findsNWidgets(0));

    expect(find.byType(Scaffold), findsOneWidget);
  });
}
