import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Apex Legends',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            tileColor: Colors.blueGrey,
            subtitle: Text('Description of item 1'),
            leading: Image.asset("assets/images/apex.jpg"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Tekken 8',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            tileColor: Colors.blueGrey,
            subtitle: Text('Description of item 1'),
            leading: Image.asset("assets/images/tekken-8.jpg"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Zelda',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            tileColor: Colors.blueGrey,
            subtitle: Text('Description of item 2'),
            leading: Image.asset("assets/images/zelda.jpg"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Valorant',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            tileColor: Colors.blueGrey,
            subtitle: Text('Description of item 3'),
            leading: Image.asset("assets/images/valorant.jpg"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Cyberpunk',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            tileColor: Colors.blueGrey,
            subtitle: Text('Description of item 2'),
            leading: Image.asset("assets/images/cyberpunk.jpg"),
          ),
        ),
        Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) => print('Dismissed'),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text('Minecraft',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              tileColor: Colors.blueGrey,
              subtitle: Text('Description of item 3'),
              leading: Image.asset("assets/images/minecraft.jpg"),
            ),
          ),
        ),
      ],
    );
  }
}
