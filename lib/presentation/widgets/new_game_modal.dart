import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/game.dart';
import '../../providers/game_provider.dart';
import '../../providers/user_session_provider.dart';

class NewGameModal extends ConsumerStatefulWidget {
  const NewGameModal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewGameModalState();
}

class _NewGameModalState extends ConsumerState<NewGameModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _platformController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _releaseDateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _imageUrlController.dispose();
    _genreController.dispose();
    _descriptionController.dispose();
    _platformController.dispose();
    _publisherController.dispose();
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
            'Game Details',
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
            controller: _platformController,
            decoration: const InputDecoration(
              labelText: 'Platform',
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
          const SizedBox(height: 300),
          ElevatedButton.icon(
            onPressed: () {
              ref
                  .read(gameListProvider(ref.read(userSessionProvider).token!)
                      .notifier)
                  .createGame(
                    Game(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      genre: _genreController.text,
                      platform: _platformController.text,
                      publisher: _publisherController.text,
                      releaseDate: _releaseDateController.text,
                      imageUrl: _imageUrlController.text,
                    ),
                  );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            icon: const Icon(Icons.save),
            label: const Text('Create game',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
