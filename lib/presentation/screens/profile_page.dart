import "package:flutter/material.dart";

import "../widgets/profile_pic_picker.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _textController = TextEditingController();
  final _emailController = TextEditingController();
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
    var _profilePic = Image.asset('assets/images/apex.jpg');

    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => const ProfilePicPicker(),
              ).then((pickedImage) {
                // do something with the picked image
              });
            },
            onTap: () {
              // pop if snackbar is already showing
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  elevation: 10,
                  backgroundColor: Colors.grey[900],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  content: Text('Press and hold to edit your avatar!'),
                ),
              );
            },
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/apex.jpg'),
                  radius: 50,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Meowsalot',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Row(
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
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: this._textController,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                  prefixIconColor: Colors.blue[700],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: this._emailController,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  prefixIconColor: Colors.blue[700],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Log out'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[700]),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Update'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue[700]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
