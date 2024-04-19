import 'package:flutter/material.dart';
import '../models/game.dart';

class EditDelete extends StatelessWidget {
  const EditDelete({super.key, required this.game});
  final Game game;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      constraints: const BoxConstraints(maxHeight: 600),
                      backgroundColor: Colors.blueGrey[800],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      builder: (context) => EditGameBottomSheet(game: game),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Edit game detail'),
                ),
              ),
              const SizedBox(height: 7),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Delete game'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class EditGameBottomSheet extends StatefulWidget {
  const EditGameBottomSheet({super.key, required this.game});
  final Game game;

  @override
  State<EditGameBottomSheet> createState() => _EditGameBottomSheetState();
}

class _EditGameBottomSheetState extends State<EditGameBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.game.title;
    _imageUrlController.text = widget.game.imageUrl;
    _genreController.text = widget.game.genre;
    _descriptionController.text = widget.game.description;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageUrlController.dispose();
    _genreController.dispose();
    _descriptionController.dispose();
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
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              labelStyle: TextStyle(color: Colors.white),
            ),
            maxLines: 3,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text('Save Changes',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
