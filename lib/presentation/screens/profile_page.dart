import 'package:flutter/material.dart';
import 'package:video_game_catalogue_app/presentation/data/accounts.dart';
import 'package:video_game_catalogue_app/presentation/widgets/administrators.dart';

import '../data/avatars.dart';
import '../widgets/avatar_picker_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  int avatarIndex = 0;

  @override
  void initState() {
    super.initState();
    _textController.text = "Meowsalot";
    _emailController.text = "meowsalot@gmail.com";
  }

  @override
  void dispose() {
    _textController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.blueGrey[900],
            elevation: 10,
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(avatars[avatarIndex]),
                        radius: 50,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const AvatarPickerDialog(),
                            ).then((value) {
                              setState(() {
                                if (value == null) {
                                  avatarIndex = 0;
                                } else {
                                  avatarIndex = value;
                                }
                              });
                            });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Meowsalot',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Join date: ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          Text(
                            "2023-03-08",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _textController,
                        style: const TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.person),
                          prefixIconColor: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.email),
                          prefixIconColor: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.red[700]),
                            ),
                            child: const Text('Log out'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Show bottom sheet for editing profile
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.blueGrey[800],
                                builder: (context) => EditProfileBottomSheet(
                                  initialUsername: _textController.text,
                                  initialEmail: _emailController.text,
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue[700]),
                            ),
                            child: const Text('Update'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          (accounts[0].userType == "Owner" || accounts[0].userType == "Admin")
              ? const AdminContainer()
              : const SizedBox(),
        ],
      ),
    );
  }
}
class EditProfileBottomSheet extends StatefulWidget {
  final String initialUsername;
  final String initialEmail;

  const EditProfileBottomSheet({super.key, 
    required this.initialUsername,
    required this.initialEmail,
  });

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
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
      child: Column(
        children: [
          const Text('Edit Profile', style: TextStyle(fontSize: 20, color: Colors.white)),
          const SizedBox(height: 20),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Save the edited profile details
              String updatedUsername = _usernameController.text;
              String updatedEmail = _emailController.text;
             
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text('Save Changes', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
