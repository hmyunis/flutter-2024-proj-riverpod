import 'package:flutter/material.dart';
import '../data/games.dart';
import '../widgets/games_list.dart';

class AvailableGames extends StatelessWidget {
  const AvailableGames({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        title: const Text("ALL GAMES"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: GamesList(games),
    );
  }
}
