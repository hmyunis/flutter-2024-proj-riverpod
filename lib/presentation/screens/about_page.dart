import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});
  String aboutPageContent = '''
## About Video Game Catalogue

Welcome to Video Game Catalogue, the ultimate mobile companion for gaming enthusiasts! Developed using Flutter, our app is designed to enhance your gaming experience by providing intuitive game management and a community-driven review system.

### Features:

#### Game Management:
Easily explore and navigate through a diverse catalog of games.
Add your favorite games to your collection for quick access.
Enjoy a structured overview of your gaming interests.
Flexibility to remove games from your favorites as your preferences evolve.

#### Review System:
Provide detailed feedback and ratings for each game.
Utilize a 5-star rating system to express your opinions.
Explore reviews from other users to discover new games.
Write, edit, or delete your own reviews as needed.

### Our Vision:
At Video Game Catalogue, we envision a platform where gamers can seamlessly manage their gaming preferences and actively engage with a vibrant community. Whether you're a casual player or a hardcore gamer, our app is tailored to meet your needs and foster a sense of camaraderie among fellow gaming enthusiasts.

### Join Us:
Download Video Game Catalogue now and embark on a journey to discover, organize, and review your favorite games like never before. Let's build a thriving gaming community together!
''';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body:  Center(
        child: Text(aboutPageContent),
      ),
    );
  }
}
