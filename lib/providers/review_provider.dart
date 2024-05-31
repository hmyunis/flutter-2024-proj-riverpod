import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/reviews_repository.dart';
import '../data/repositories/users_repository.dart';
import '../data/services/reviews_api_service.dart';
import '../data/services/users_api_service.dart';
import '../models/game.dart';
import '../models/review.dart';

final reviewListProvider =
    AsyncNotifierProvider.autoDispose<ReviewNotifier, List<Review>>(
        ReviewNotifier.new);

typedef RatingCommentsParameters = ({Game game, int? userId});

final gameRatingCommentsProvider = FutureProvider.autoDispose
    .family<List, RatingCommentsParameters>((ref, arguments) async {
  final ReviewsRepository reviewsRepository =
      ReviewsRepository(ReviewsApiService());
  final reviews =
      await reviewsRepository.getReviewsByGameId(arguments.game.id!);
  final returnedValues = []; // userLastRating, averageRating, numReviews

  final sortedReviews = reviews.reversed.toList();
  for (var review in sortedReviews) {
    if (review.userId == arguments.userId && review.rating != 0) {
      final userLastRating = review.rating;
      returnedValues.add(userLastRating);
      break;
    }
  }
  if (returnedValues.isEmpty) {
    const userLastRating = 0;
    returnedValues.add(userLastRating);
  }
  num sum = 0;
  for (var review in sortedReviews) {
    sum += review.rating;
  }
  final int ratedGameReviews =
      reviews.where((review) => review.rating != 0).length;
  final averageRating = sum / (ratedGameReviews == 0 ? 1 : ratedGameReviews);

  final commentContainingReviews =
      reviews.where((review) => review.comment != "").toList();
  final int numComments = commentContainingReviews.length;

  returnedValues.add(averageRating);
  returnedValues.add(numComments);

  if (returnedValues.length != 3) {
    throw Exception();
  }

  final userIdToUsernameMap = <int, String>{};
  final UsersRepository usersRepository = UsersRepository(UsersApiService());
  final users = await usersRepository.getUsers();
  for (var user in users) {
    userIdToUsernameMap[user.id!] = user.username;
  }

  return [
    sortedReviews.where((review) => review.comment != "").toList(),
    userIdToUsernameMap,
    returnedValues[0], // userLastRating
    returnedValues[1], // averageRating
    returnedValues[2], // numComments
  ];
});

class ReviewNotifier extends AutoDisposeAsyncNotifier<List<Review>> {
  @override
  Future<List<Review>> build() async {
    final ReviewsRepository reviewsRepository =
        ReviewsRepository(ReviewsApiService());
    return await reviewsRepository.getReviews();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> addGameRating(Review review) async {
    final ReviewsRepository reviewsRepository =
        ReviewsRepository(ReviewsApiService());
    final List<Review> allReviews =
        await reviewsRepository.getReviewsByGameId(review.gameId);
    bool userAlreadyRated = false;
    for (var r in allReviews) {
      if (r.userId == review.userId && r.comment == "") {
        userAlreadyRated = true;
        break;
      }
    }
    if (userAlreadyRated) return;
    await reviewsRepository.addReview(Review(
      userId: review.userId,
      gameId: review.gameId,
      rating: review.rating,
      comment: '',
    ));

    await refresh();
  }

  Future<void> updateGameRating(Review review) async {
    final ReviewsRepository reviewsRepository =
        ReviewsRepository(ReviewsApiService());
    final allReviews =
        await reviewsRepository.getReviewsByGameId(review.gameId);
    final Review reviewToBeUpdated = allReviews
        .firstWhere((r) => r.userId == review.userId && r.comment == "");
    await reviewsRepository.updateReview(
        reviewToBeUpdated.id!,
        Review(
          userId: reviewToBeUpdated.userId,
          gameId: reviewToBeUpdated.gameId,
          rating: review.rating,
          comment: reviewToBeUpdated.comment,
        ));

    await refresh();
  }

  Future<void> addGameComment(Review review) async {
    final ReviewsRepository reviewsRepository =
        ReviewsRepository(ReviewsApiService());
    await reviewsRepository.addReview(Review(
      userId: review.userId,
      gameId: review.gameId,
      comment: review.comment,
      rating: 0,
    ));

    await refresh();
  }

  Future<void> updateGameComment(Review review, String newComment) async {
    final ReviewsRepository reviewsRepository =
        ReviewsRepository(ReviewsApiService());
    final allReviews =
        await reviewsRepository.getReviewsByGameId(review.gameId);
    final Review reviewToBeUpdated = allReviews.firstWhere(
        (r) => r.userId == review.userId && r.comment == review.comment);
    await reviewsRepository.updateReview(
        reviewToBeUpdated.id!,
        Review(
          userId: review.userId,
          gameId: review.gameId,
          rating: review.rating,
          comment: newComment,
        ));

    await refresh();
  }

  Future<void> deleteGameComment(Review review) async {
    final ReviewsRepository reviewsRepository =
        ReviewsRepository(ReviewsApiService());
    final allReviews =
        await reviewsRepository.getReviewsByGameId(review.gameId);
    final Review reviewToBeDeleted = allReviews.firstWhere(
      (r) =>
          r.userId == review.userId && r.comment == review.comment,
    );
    await reviewsRepository.deleteReview(reviewToBeDeleted.id!);

    await refresh();
  }
}
