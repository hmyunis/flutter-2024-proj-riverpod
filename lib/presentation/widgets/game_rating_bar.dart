import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/game.dart';
import '../../models/review.dart';
import '../../providers/review_provider.dart';
import '../../providers/user_session_provider.dart';

class GameRatingBar extends ConsumerWidget {
  const GameRatingBar({
    required this.game,
    required this.userLastRating,
    required this.averageRating,
    super.key,
  });
  final Game game;
  final int userLastRating;
  final double averageRating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(
          width: double.maxFinite,
          child: Text(
            "Ratings and reviews",
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              averageRating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 52,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    if (userLastRating == 0) {
                      ref
                          .read(reviewListProvider.notifier)
                          .addGameRating(
                            Review(
                              userId: ref.read(userSessionProvider).id!,
                              gameId: game.id!,
                              rating: index + 1,
                            ),
                          )
                          .whenComplete(() {
                        ref.invalidate(gameRatingCommentsProvider);
                      });

                      return;
                    }
                    ref
                        .read(reviewListProvider.notifier)
                        .updateGameRating(
                          Review(
                            userId: ref.read(userSessionProvider).id!,
                            gameId: game.id!,
                            rating: index + 1,
                          ),
                        )
                        .whenComplete(() {
                      ref.invalidate(gameRatingCommentsProvider);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      index < userLastRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
