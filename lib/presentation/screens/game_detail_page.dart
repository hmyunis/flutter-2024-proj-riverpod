import 'package:flutter/material.dart';
import 'package:video_game_catalogue_app/presentation/models/game.dart';
import 'package:video_game_catalogue_app/presentation/widgets/games_list.dart';

class GameDetailPage extends StatefulWidget {
  const GameDetailPage({super.key, required this.game});
  final Game game;

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  @override
  Widget build(BuildContext context) {
    int currentRating = 4;

    return Scaffold(
        backgroundColor: Colors.blueGrey[700],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text(widget.game.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  widget.game.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 450,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Title: ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.game.title,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Genre: ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.game.genre,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Description: ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.game.description,
                            style: const TextStyle(
                              fontSize: 16,
                              letterSpacing: 1.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  const SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      "Ratings and reviews",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "4.0",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      StarRating(
                        rating: currentRating,
                        onRatingChanged: (newRating) {
                          setState(() {
                            currentRating = newRating;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // TODO: List of reviews
            ],
          ),
        ));
  }
}

class StarRating extends StatefulWidget {
  final int rating;
  final Function(int) onRatingChanged;

  const StarRating(
      {Key? key, required this.rating, required this.onRatingChanged})
      : super(key: key);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < widget.rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            widget.onRatingChanged(index + 1);
          },
        );
      }),
    );
  }
}
