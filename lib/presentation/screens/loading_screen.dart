import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';
import '../../providers/user_session_provider.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return authState.when(
      data: (data) {
        Future(() {
          ref.read(userSessionProvider.notifier).setUser(data.user!);
        }).whenComplete(() {
          context.go('/home');
        });
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
                    leading: const Icon(Icons.logout),
                    title: const Text("L O G   O U T"),
                    onTap: () {
                      context.go('/');
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
                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.blueGrey[700],
                backgroundColor: Colors.blueGrey[900],
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.explore_rounded),
                    label: 'Explore',
                    backgroundColor: Colors.transparent,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.star_rounded,
                      color: Colors.amber[300],
                    ),
                    label: 'Favorites',
                    backgroundColor: Colors.transparent,
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded),
                    label: 'Profile',
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.blueGrey[700],
          body: const Center(
            child: CircularProgressIndicator(color: Colors.blueGrey),
          ),
        );
      },
      loading: () => Scaffold(
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
                  leading: const Icon(Icons.logout),
                  title: const Text("L O G   O U T"),
                  onTap: () {
                    context.go('/');
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
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.blueGrey[700],
              backgroundColor: Colors.blueGrey[900],
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.explore_rounded),
                  label: 'Explore',
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.star_rounded,
                    color: Colors.amber[300],
                  ),
                  label: 'Favorites',
                  backgroundColor: Colors.transparent,
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'Profile',
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.blueGrey[700],
        body: const Center(
          child: CircularProgressIndicator(color: Colors.blueGrey),
        ),
      ),
      error: (error, stackTrace) {
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
                    leading: const Icon(Icons.logout),
                    title: const Text("L O G   O U T"),
                    onTap: () {
                      context.go('/');
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
                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.blueGrey[700],
                backgroundColor: Colors.blueGrey[900],
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.explore_rounded),
                    label: 'Explore',
                    backgroundColor: Colors.transparent,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.star_rounded,
                      color: Colors.amber[300],
                    ),
                    label: 'Favorites',
                    backgroundColor: Colors.transparent,
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded),
                    label: 'Profile',
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.blueGrey[700],
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber_rounded,
                    size: 120, color: Colors.red.withOpacity(0.5)),
                const SizedBox(height: 16),
                const Text("Invalid login credentials"),
                const SizedBox(height: 16),
                const CircularProgressIndicator(color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  "Returning to login page...",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Builder(builder: (context) {
                  Future.delayed(const Duration(seconds: 3), () {
                    context.go('/');
                  });
                  return Container();
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
