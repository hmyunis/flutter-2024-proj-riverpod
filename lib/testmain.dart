import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:video_game_catalogue_riverpod/models/game.dart";
import "package:video_game_catalogue_riverpod/models/review.dart";
import "package:video_game_catalogue_riverpod/models/user.dart";
import "package:video_game_catalogue_riverpod/presentation/screens/loading_screen.dart";
import "package:video_game_catalogue_riverpod/presentation/widgets/avatar_picker_dialog.dart";
import "package:video_game_catalogue_riverpod/presentation/widgets/comment_section.dart";
import "package:video_game_catalogue_riverpod/presentation/widgets/edit_delete.dart";
import "package:video_game_catalogue_riverpod/presentation/widgets/favorite_item.dart";
import "package:video_game_catalogue_riverpod/presentation/widgets/user_details_dialog.dart";

void main() {
  final user = User(
    id: 1,
    username: 'john_doe',
    email: 'john.doe@example.com',
    joinDate: '2022-01-01',
    role: 'admin',
  );
  final testGame = Game(
    id: 1,
    title: 'Test Game',
    imageUrl: 'assets/images/games/ac-origins.jpg',
    description: 'This is a test game description.',
    genre: 'Adventure',
    platform: 'PC',
    publisher: 'Test Publisher',
    releaseDate: '2022-01-01',
  );
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: EditDelete(
              game: Game(
            id: 1,
            title: 'Test Game',
            description: 'This is a test game',
            genre: 'Action',
            platform: 'PS4',
            publisher: 'Test Publisher',
            releaseDate: '2022-01-01',
            imageUrl: 'https://example.com/image.jpg',
          )),
        ),
      ),
    ),
  );
}
