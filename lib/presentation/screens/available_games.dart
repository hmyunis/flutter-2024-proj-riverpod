import 'package:flutter/material.dart';
import 'browse_page.dart';

class AvailableGames extends StatelessWidget {
  const AvailableGames({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text(
          'A L L  G A M E S',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
      ),
      body: BrowsePage(),
    );
  }
}
