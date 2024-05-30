import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/avatars.dart';
import '../../providers/avatar_provider.dart';

// ignore: must_be_immutable
class AvatarPickerDialog extends ConsumerWidget {
  AvatarPickerDialog({super.key});

  int _selectedAvatarIndex = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text(
        'Select an Avatar',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      backgroundColor: Colors.blueGrey[300],
      content: SizedBox(
        height: 300,
        width: double.maxFinite,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          shrinkWrap: true,
          itemCount: avatars.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _selectedAvatarIndex = index;
                ref
                    .read(avatarProvider.notifier)
                    .setIndex(_selectedAvatarIndex);
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 2.0,
                  ),
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage(avatars[index]),
                  radius: 30.0,
                  backgroundColor: _selectedAvatarIndex == index
                      ? Colors.blue.withOpacity(0.5)
                      : Colors.transparent,
                ),
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
