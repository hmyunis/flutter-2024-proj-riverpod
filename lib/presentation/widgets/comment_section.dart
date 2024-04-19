import 'package:flutter/material.dart';
import 'package:video_game_catalogue_app/presentation/data/reviews.dart';
import 'package:video_game_catalogue_app/presentation/models/review.dart';

import '../models/game.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key, required this.game});
  final Game game;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  bool hasComments(String gameTitle) {
    if (reviews.any((review) => review.gameTitle == gameTitle)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Review> filteredReviews = reviews
        .where((review) => review.gameTitle == widget.game.title)
        .toList();
    return SizedBox(
      width: 200,
      height: 500,
      child: Column(
        children: [
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemBuilder: (context, index) {
                if (!hasComments(widget.game.title)) {
                  return const Center(
                    child: Text(
                      'No comments yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      reviews.removeAt(index);
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 10),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  child: ListTile(
                    tileColor: Colors.blueGrey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    leading: const Icon(
                      Icons.account_circle,
                      size: 40,
                      color: Colors.blueGrey,
                    ),
                    title: Text(
                      filteredReviews[index].username,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      filteredReviews[index].comment,
                      // overflow: TextOverflow.ellipsis,
                      // maxLines: 2,
                    ),
                    trailing: Text(
                      filteredReviews[index].date,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
              itemCount: reviews
                  .where((review) => review.gameTitle == widget.game.title)
                  .length,
            ),
          ),
        ],
      ),
    );
  }
}
