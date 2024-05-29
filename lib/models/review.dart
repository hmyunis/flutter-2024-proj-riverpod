class Review {
  final int? id;
  final int userId;
  final int gameId;
  final String? comment;
  final int rating;
  final String? createdAt;

  Review({
    this.id,
    required this.userId,
    required this.gameId,
    this.comment,
    required this.rating,
    this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userId: json['userId'],
      gameId: json['gameId'],
      comment: json['comment'],
      rating: json['rating'],
      createdAt: json['createdAt'],
    );
  }

  @override
  String toString() {
    return 'Review(id: $id, userId: $userId, gameId: $gameId, comment: $comment, rating: $rating, createdAt: $createdAt)';
  }
}
