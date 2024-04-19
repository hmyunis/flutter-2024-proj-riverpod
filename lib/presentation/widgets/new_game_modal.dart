import 'package:flutter/material.dart';

class NewGameModal extends StatefulWidget {
  const NewGameModal({super.key});

  @override
  State<NewGameModal> createState() => _NewGameModalState();
}

class _NewGameModalState extends State<NewGameModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
            child: const Text('Create game',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}