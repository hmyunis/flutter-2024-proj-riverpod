import 'package:flutter/material.dart';

class ProfilePicPicker extends StatefulWidget {
  const ProfilePicPicker({super.key});

  @override
  State<ProfilePicPicker> createState() => _ProfilePicPickerState();
}

class _ProfilePicPickerState extends State<ProfilePicPicker> {
  @override
  Widget build(BuildContext context) {
    var selectedImage = Image.asset('assets/images/apex.jpg');

    final images = [
      Image.asset('assets/images/apex.jpg'),
      Image.asset('assets/images/valorant.jpg'),
      Image.asset('assets/images/minecraft.jpg'),
      Image.asset('assets/images/zelda.jpg'),
      Image.asset('assets/images/tekken-8.jpg'),
      Image.asset('assets/images/cyberpunk.jpg')
    ];
// Inside ProfilePicPickerState
    return GridView.count(
      crossAxisCount: 5,
      children: List.generate(images.length, (index) {
        return GestureDetector(
          onTap: () {
            // Handle image selection
            setState(() {
              selectedImage = images[index];
            });
            Navigator.pop(context, selectedImage);
          },
          child: CircleAvatar(
            backgroundImage: images[index].image,
            radius: 50,
          ),
        );
      }),
    );
  }
}
