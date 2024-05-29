class Collection {
  final int? id;
  final String status;
  final int gameId;
  final int userId;

  Collection({
    this.id,
    required this.status,
    required this.gameId,
    required this.userId,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'],
      status: json['status'],
      gameId: json['gameId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'gameId': gameId,
      'userId': userId,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Collection otherCollection = other as Collection;
    return id == otherCollection.id &&
           status == otherCollection.status &&
           gameId == otherCollection.gameId &&
           userId == otherCollection.userId;
  }

  @override
  int get hashCode => id.hashCode ^ status.hashCode ^ gameId.hashCode ^ userId.hashCode;

  @override
  String toString() {
    return 'Collection{id: $id, status: $status, gameId: $gameId, userId: $userId}';
  }
}
