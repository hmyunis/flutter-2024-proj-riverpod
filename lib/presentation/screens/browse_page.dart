import 'package:flutter/material.dart';
import '../data/games.dart';
import '../widgets/games_list.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blueGrey, Colors.grey],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ],
          ),
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          height: 100,
          width: double.maxFinite,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text(
            "B R O W S E",
            style: TextStyle(
              fontSize: 24,
              color: Colors.blue[900],
            ),
          ),
        ),
        Expanded(
          child: GamesList(games),
        ),
      ],
    );
  }
}
