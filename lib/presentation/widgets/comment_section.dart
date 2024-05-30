import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_game_catalogue_riverpod/providers/review_provider.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';
import '../../models/review.dart';

class CommentSection extends ConsumerStatefulWidget {
  const CommentSection(
      {super.key,
      required this.reviews,
      required this.userIdToUsernameMap,
      required this.numReviews});
  final List<Review> reviews;
  final Map<int, String> userIdToUsernameMap;
  final int numReviews;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentSectionState();
}

class _CommentSectionState extends ConsumerState<CommentSection> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _showCommentEditDialog(Review review) async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        _commentController.text = review.comment!;
        return AlertDialog(
          title: const Text('Edit comment'),
          content: SizedBox(
            width: 400,
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                prefixIcon: Icon(Icons.edit),
              ),
              autocorrect: true,
              maxLines: null,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.blueGrey[100],
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (_commentController.text.trim() == "" ||
        confirmed == false ||
        confirmed == null) {
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
                "Comment update aborted.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              )
            ],
          ),
          backgroundColor: Colors.blueGrey.withOpacity(0.5),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      );
      return;
    }

    if (confirmed) {
      ref.read(reviewListProvider.notifier).updateGameComment(
          Review(
            userId: review.userId,
            gameId: review.gameId,
            comment: review.comment,
            rating: 0,
          ),
          _commentController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Comment updated successfully.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              )
            ],
          ),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.blueGrey.withOpacity(0.5),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(
            height: 5,
          ),
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                if (ref.read(userSessionProvider).id ==
                    widget.reviews[index].userId) {
                  ref
                      .read(reviewListProvider.notifier)
                      .deleteGameComment(Review(
                        userId: widget.reviews[index].userId,
                        gameId: widget.reviews[index].gameId,
                        comment: widget.reviews[index].comment,
                        rating: 0,
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.disabled_by_default_rounded,
                            color: Colors.red[300],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Flexible(
                            child: Text(
                              "You can only delete your own comments.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      backgroundColor: Colors.blueGrey.withOpacity(0.5),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  );
                  setState(() {
                    widget.reviews.insert(index, widget.reviews[index]);
                  });
                }
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
              child: GestureDetector(
                onTap: () {
                  if (ref.read(userSessionProvider).id ==
                      widget.reviews[index].userId) {
                    _showCommentEditDialog(widget.reviews[index]);
                  }
                },
                child: ListTile(
                  tileColor: (ref.read(userSessionProvider).id ==
                          widget.reviews[index].userId)
                      ? Colors.grey[100]
                      : Colors.blueGrey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(color: Colors.blueGrey, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  leading: Icon(
                    Icons.account_circle,
                    size: 40,
                    color: (ref.read(userSessionProvider).id ==
                            widget.reviews[index].userId)
                        ? Colors.cyan[700]
                        : Colors.blueGrey,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.userIdToUsernameMap[
                                  widget.reviews[index].userId] ??
                              "DELETED ACCOUNT",
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 2.0,
                            color: (ref.read(userSessionProvider).id ==
                                    widget.reviews[index].userId)
                                ? Colors.cyan[800]
                                : Colors.blueGrey,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.reviews[index].createdAt
                                .toString()
                                .substring(
                                    0,
                                    widget.reviews[index].createdAt
                                        .toString()
                                        .indexOf(",")),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            " |${widget.reviews[index].createdAt.toString().substring(
                                  widget.reviews[index].createdAt
                                          .toString()
                                          .indexOf(",") +
                                      1,
                                )}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Text(widget.reviews[index].comment!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey[900],
                      )),
                ),
              ),
            );
          },
          itemCount: widget.numReviews,
        ),
      ],
    );
  }
}
