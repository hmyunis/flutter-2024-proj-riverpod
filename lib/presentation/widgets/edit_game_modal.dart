import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_game_catalogue_riverpod/providers/game_provider.dart';
import '../../models/game.dart';
import '../../providers/user_session_provider.dart';

class EditGameBottomSheet extends ConsumerStatefulWidget {
  const EditGameBottomSheet({super.key, required this.game});
  final Game game;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditGameBottomSheetState();
}

class _EditGameBottomSheetState extends ConsumerState<EditGameBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _platformController = TextEditingController();
  final TextEditingController _releaseDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.game.title;
    _imageUrlController.text = widget.game.imageUrl;
    _genreController.text = widget.game.genre;
    _descriptionController.text = widget.game.description;
    _publisherController.text = widget.game.publisher;
    _platformController.text = widget.game.platform;
    _releaseDateController.text = widget.game.releaseDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageUrlController.dispose();
    _genreController.dispose();
    _descriptionController.dispose();
    _publisherController.dispose();
    _platformController.dispose();
    _releaseDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: ListView(
        children: [
          const Text(
            'Edit Game Details',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: _imageUrlController,
            decoration: const InputDecoration(
              labelText: 'Image URL',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: _genreController,
            decoration: const InputDecoration(
              labelText: 'Genre',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: _publisherController,
            decoration: const InputDecoration(
              labelText: 'Publisher',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: _platformController,
            decoration: const InputDecoration(
              labelText: 'Platform',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: _releaseDateController,
            decoration: const InputDecoration(
              labelText: 'Release Date',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              labelStyle: TextStyle(color: Colors.white),
            ),
            maxLines: 3,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              if (_titleController.text.isEmpty ||
                  _imageUrlController.text.isEmpty ||
                  _genreController.text.isEmpty ||
                  _publisherController.text.isEmpty ||
                  _platformController.text.isEmpty ||
                  _releaseDateController.text.isEmpty ||
                  _descriptionController.text.isEmpty) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Please fill in all of the fields."),
                    backgroundColor: Colors.red.withOpacity(0.3),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                );
                return;
              }

              ref
                  .read(gameListProvider(ref.read(userSessionProvider).token!)
                      .notifier)
                  .updateGame(Game(
                    id: widget.game.id!,
                    title: _titleController.text,
                    imageUrl: _imageUrlController.text,
                    genre: _genreController.text,
                    description: _descriptionController.text,
                    publisher: _publisherController.text,
                    platform: _platformController.text,
                    releaseDate: _releaseDateController.text,
                  ));

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            label: const Text(
              'Save changes',
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const CircleBorder(),
            ),
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
