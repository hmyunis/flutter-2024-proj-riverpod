import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_game_catalogue_riverpod/core/avatars.dart';
import 'package:video_game_catalogue_riverpod/providers/avatar_provider.dart';
import 'package:video_game_catalogue_riverpod/providers/review_provider.dart';

import '../../models/game.dart';
import '../../models/review.dart';
import '../../providers/user_session_provider.dart';

class CommentBox extends ConsumerStatefulWidget {
  const CommentBox({required this.game, super.key});
  final Game game;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentBoxState();
}

class _CommentBoxState extends ConsumerState<CommentBox> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blueGrey,
                ),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(avatars[ref.watch(avatarProvider)]),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Write a comment...',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                if (_commentController.text.trim().isNotEmpty) {
                  ref.read(reviewListProvider.notifier).addGameComment(Review(
                        userId: ref.read(userSessionProvider).id!,
                        gameId: widget.game.id!,
                        comment: _commentController.text,
                        rating: 0,
                      ));
                  ref.invalidate(gameRatingCommentsProvider);
                  _commentController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Please enter a comment first",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                      duration: const Duration(
                        seconds: 1,
                      ),
                      backgroundColor: Colors.blueGrey.withOpacity(0.5),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.send,
                size: 30,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
