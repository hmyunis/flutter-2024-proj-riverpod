import 'dart:convert';

import '../services/reviews_api_service.dart';

import '../../models/review.dart';

class ReviewsRepository {
  final ReviewsApiService _reviewsApiService;
  ReviewsRepository(this._reviewsApiService);

  Future<List<Review>> getReviewsByGameId(int gameId) async {
    final response =
        await _reviewsApiService.getReviewsByGameId(gameId.toString());
    final reviews = jsonDecode(response);
    final allGameReviews = <Review>[];
    for (final review in reviews) {
      allGameReviews.add(Review.fromJson(review));
    }
    return allGameReviews;
  }

  Future<Review> getReviewById(int reviewId) async {
    final response = await _reviewsApiService.getReview(reviewId.toString());
    final review = jsonDecode(response);
    return Review.fromJson(review);
  }

  Future<List<Review>> getReviews() async {
    final response = await _reviewsApiService.getReviews();
    final reviews = jsonDecode(response);
    final allReviews = <Review>[];
    for (final review in reviews) {
      allReviews.add(Review.fromJson(review));
    }
    return allReviews;
  }

  Future<Review> addReview(Review review) async {
    final response = await _reviewsApiService.addReview({
      'userId': review.userId,
      'gameId': review.gameId,
      'comment': review.comment,
      'rating': review.rating,
    });
    final newReview = jsonDecode(response);
    return Review.fromJson(newReview);
  }

  Future<void> deleteReview(int reviewId) async {
    await _reviewsApiService.deleteReview(reviewId.toString());
  }

  Future<Review> updateReview(int reviewId, Review review) async {
    final response =
        await _reviewsApiService.updateReview(reviewId.toString(), {
      'userId': review.userId,
      'gameId': review.gameId,
      'comment': review.comment,
      'rating': review.rating,
    });
    final updatedReview = jsonDecode(response);
    return Review.fromJson(updatedReview);
  }
}
