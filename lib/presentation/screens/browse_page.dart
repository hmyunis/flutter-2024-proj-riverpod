import 'package:flutter/material.dart';
import 'package:video_game_catalogue_app/presentation/data/games.dart';
import '../widgets/games_list.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  
  @override
  Widget build(BuildContext context) {
    return GamesList(games);
  }
}
