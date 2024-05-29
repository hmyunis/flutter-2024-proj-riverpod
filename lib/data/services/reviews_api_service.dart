import 'dart:convert';

import '../../core/constants.dart';

import 'package:http/http.dart' as http;

class ReviewsApiService {
  final String _baseUrl = apiBaseUrl;

  Future getReview(String reviewId) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/reviews/$reviewId"));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to load review');
    } catch (e) {
      throw e.toString();
    }
  }

  Future getReviewsByGameId(String gameId) async {
    try {
      final response =
          await http.get(Uri.parse("$_baseUrl/reviews?gameId=$gameId"));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to load reviews under gameId: $gameId');
    } catch (e) {
      throw e.toString();
    }
  }

  Future getReviews() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/reviews"));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to load reviews');
    } catch (e) {
      throw e.toString();
    }
  }

  Future addReview(Map<String, dynamic> review) async {
    try {
      final response = await http.post(Uri.parse("$_baseUrl/reviews/new"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(review));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      throw Exception('Failed to create review item');
    } catch (e) {
      throw e.toString();
    }
  }

  Future updateReview(String reviewId, Map<String, dynamic> review) async {
    try {
      final response = await http.patch(
          Uri.parse("$_baseUrl/reviews/$reviewId"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(review));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to update review item');
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteReview(String reviewId) async {
    try {
      final response =
          await http.delete(Uri.parse("$_baseUrl/reviews/$reviewId"));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to delete review');
    } catch (e) {
      throw e.toString();
    }
  }
}
