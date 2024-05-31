import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';
import '../../providers/avatar_provider.dart';
import '../../providers/user_session_provider.dart';
import 'browse_page.dart';
import 'favorites_page.dart';
import 'profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    const BrowsePage(),
    const FavoritesPage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "VIDEO GAME CATALOGUE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                context.push('/about');
              },
            );
          })
        ],
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.blueGrey[900],
        shadowColor: Colors.black,
      ),
      drawer: Drawer(
        backgroundColor: Colors.blueGrey[500],
        child: Builder(builder: (context) {
          return Column(
            children: [
              DrawerHeader(
                child: Icon(Icons.gamepad_rounded,
                    size: 80,
                    color: Colors.blue[700],
                    shadows: const [
                      Shadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(0, 5))
                    ]),
              ),
              ListTile(
                leading: const Icon(Icons.person_add_alt_1_rounded),
                title: const Text("C R E A T E   A C C O U N T"),
                onTap: () {
                  context.go('/register');
                },
              ),
              ListTile(
                key: const Key("logout"),
                leading: const Icon(Icons.logout),
                title: const Text("L O G   O U T"),
                onTap: () {
                  ref.read(authProvider.notifier).logout();
                  ref.read(userSessionProvider.notifier).clear();
                  ref.read(avatarProvider.notifier).reset();
                  context.go('/');
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              "You logged out.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      backgroundColor: Colors.red.withOpacity(0.5),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("A B O U T"),
                onTap: () {
                  context.push('/about');
                },
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey[900]!.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _navigateBottomBar,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.blueGrey[700],
            backgroundColor: Colors.blueGrey[900],
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.explore_rounded),
                label: 'Explore',
                backgroundColor: _selectedIndex == 0
                    ? Colors.blueGrey[800]
                    : Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.star_rounded,
                  color: Colors.amber[300],
                ),
                label: 'Favorites',
                backgroundColor: _selectedIndex == 1
                    ? Colors.blueGrey[800]
                    : Colors.transparent,
              ),
              BottomNavigationBarItem(
                key: const Key("profile_icon"),
                icon: const Icon(Icons.person_rounded),
                label: 'Profile',
                backgroundColor: _selectedIndex == 2
                    ? Colors.blueGrey[800]
                    : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[700],
      body: _pages[_selectedIndex],
    );
  }
}
