import 'package:flutter/material.dart';
import '../models/game.dart';
import '../widgets/games_list.dart';

class BrowsePage extends StatelessWidget {
  BrowsePage({super.key});

  final List<Game> games = [
    Game(
      description: "Waste your life!",
      title: "Minecraft",
      genre: "Strategy",
      imageUrl: 'assets/images/minecraft.jpg',
    ),
    Game(
      description: "Funky as it can get!",
      title: "Cyberpunk",
      genre: "Action",
      imageUrl: 'assets/images/cyberpunk.jpg',
    ),
    Game(
      description: "Smash your enemies to pieces!",
      title: "Tekken 8",
      genre: "Fighting",
      imageUrl: 'assets/images/tekken-8.jpg',
    ),
    Game(
      description: "Edgy plot of your life!",
      title: "Valorant",
      genre: "RPG",
      imageUrl: 'assets/images/valorant.jpg',
    ),
    Game(
      description: "Fight to the death!",
      title: "Zelda",
      genre: "Action",
      imageUrl: 'assets/images/zelda.jpg',
    ),
    Game(
      description: "Kill your mobile battery in seconds!",
      title: "Apex Legends",
      genre: "RPG",
      imageUrl: 'assets/images/apex.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GamesList(games);
  }
}
