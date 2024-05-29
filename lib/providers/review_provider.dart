import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/reviews_repository.dart';
import '../data/services/reviews_api_service.dart';
import '../models/review.dart';

final reviewListProvider =
    AsyncNotifierProvider.autoDispose<ReviewNotifier, List<Review>>(
        ReviewNotifier.new);

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
    final Review reviewToBeUpdated = allReviews.firstWhere(
        (review) => review.userId == review.userId && review.comment == "");
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
    final Review reviewToBeUpdated = allReviews.firstWhere((review) =>
        review.userId == review.userId && review.comment == review.comment);
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
      (review) =>
          review.userId == review.userId && review.comment == review.comment,
    );
    await reviewsRepository.deleteReview(reviewToBeDeleted.id!);

    await refresh();
  }
}
