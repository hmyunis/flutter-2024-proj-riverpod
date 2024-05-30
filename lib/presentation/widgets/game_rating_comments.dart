import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/user_session_provider.dart';
import '../../models/game.dart';
import '../../providers/review_provider.dart';
import 'comment_box.dart';
import 'comment_section.dart';
import 'game_rating_bar.dart';

class GameRatingComments extends ConsumerWidget {
  const GameRatingComments({
    required this.game,
    super.key,
  });
  final Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List> state = ref.watch(gameRatingCommentsProvider(
        (game: game, userId: ref.read(userSessionProvider).id)));

    return switch (state) {
      AsyncData(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GameRatingBar(
                game: game,
                userLastRating: value[2],
                averageRating: value[3],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CommentBox(game: game),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 1.5,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.5),
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.fromLTRB(18, 2, 18, 2),
                  child: Text(
                    value[4].toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            CommentSection(
              reviews: value[0],
              userIdToUsernameMap: value[1],
              numReviews: value[4],
            ),
          ],
        ),
      AsyncError() => const Scaffold(
          body: Center(
            child: Text("Error, please try again"),
          ),
        ),
      _ => const Center(
          child: CircularProgressIndicator(
            color: Colors.cyan,
          ),
        ),
    };
  }
}
