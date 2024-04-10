import 'package:flutter/material.dart';
import 'presentation/screens/browse_page.dart';
import 'presentation/screens/favorites_page.dart';
import 'presentation/screens/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    BrowsePage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Video Game Catalogue",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 1.5),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // modal bottom sheet
              },
              icon: Icon(Icons.info),
            )
          ],
          centerTitle: true,
          elevation: 10,
          backgroundColor: Colors.blueGrey[900],
          // backgroundColor: Theme.of(context).primaryColor,
          shadowColor: Colors.black,
        ),
        drawer: Drawer(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          selectedItemColor: Colors.blueGrey[300],
          unselectedItemColor: Colors.blueGrey[700],
          backgroundColor: Colors.blueGrey[900],
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.star_outlined,
                color: Color.fromARGB(255, 139, 117, 50),
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey[700],
        body: _pages[_selectedIndex],
      ),
    );
  }
}
