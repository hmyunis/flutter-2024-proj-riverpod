import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:video_game_catalogue_riverpod/models/review.dart";
import "package:video_game_catalogue_riverpod/presentation/screens/loading_screen.dart";
import "package:video_game_catalogue_riverpod/presentation/widgets/avatar_picker_dialog.dart";
import "package:video_game_catalogue_riverpod/presentation/widgets/comment_section.dart";

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: CommentSection(
          reviews: [
            Review(
                id: 1, userId: 1, gameId: 1, comment: 'Great game!', rating: 1),
            Review(id: 2, userId: 2, gameId: 1, comment: 'Not bad', rating: 3),
          ],
          numReviews: 0,
          userIdToUsernameMap: {1: 'user1', 2: 'user2'},
        ),
      ),
    ),
  );
}
