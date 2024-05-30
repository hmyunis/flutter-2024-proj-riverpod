import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/game.dart';
import '../widgets/game_info.dart';
import '../widgets/game_rating_comments.dart';

// ignore: must_be_immutable
class GameDetailPage extends ConsumerStatefulWidget {
  GameDetailPage({super.key, required this.game});
  Game game;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends ConsumerState<GameDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text(widget.game.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            GameInfo(game: widget.game),
            GameRatingComments(game: widget.game),
          ],
        ),
      ),
    );
  }
}
