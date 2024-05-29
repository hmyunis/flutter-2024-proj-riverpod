final class Game {
  final int? id;
  final String title;
  final String description;
  final String genre;
  final String platform;
  final String publisher;
  final String releaseDate;
  final String imageUrl;

  Game({
    this.id,
    required this.title,
    required this.description,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.releaseDate,
    required this.imageUrl,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      genre: json['genre'],
      platform: json['platform'],
      publisher: json['publisher'],
      releaseDate: json['releaseDate'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'genre': genre,
      'platform': platform,
      'publisher': publisher,
      'releaseDate': releaseDate,
      'imageUrl': imageUrl,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Game otherGame = other as Game;
    return id == otherGame.id &&
           title == otherGame.title &&
           description == otherGame.description &&
           genre == otherGame.genre &&
           platform == otherGame.platform &&
           publisher == otherGame.publisher &&
           releaseDate == otherGame.releaseDate &&
           imageUrl == otherGame.imageUrl;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode ^ genre.hashCode ^ platform.hashCode ^ publisher.hashCode ^ releaseDate.hashCode ^ imageUrl.hashCode;

  @override
  String toString() {
    return 'Game{id: $id, title: $title, description: $description, genre: $genre, platform: $platform, publisher: $publisher, releaseDate: $releaseDate, imageUrl: $imageUrl}';
  }
}