import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_game_catalogue_riverpod/presentation/screens/loading_screen.dart';
import '../presentation/screens/about_page.dart';
import '../presentation/screens/browse_page.dart';
// import '../presentation/screens/favorites_page.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/login_page.dart';
// import '../presentation/screens/profile_screen.dart';
// import '../presentation/screens/registration_page.dart';
// import '../presentation/screens/role_mgt_screen.dart';

GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      pageBuilder: (context, state) => const MaterialPage(
        child: LoginPage(),
      ),
    ),
    // GoRoute(
    //   path: "/register",
    //   pageBuilder: (context, state) => const MaterialPage(
    //     child: RegistrationPage(),
    //   ),
    // ),
    GoRoute(
      path: "/home",
      pageBuilder: (context, state) => const MaterialPage(
        child: HomeScreen(),
      ),
    ),
    GoRoute(
      path: "/browse",
      pageBuilder: (context, state) => const MaterialPage(
        child: BrowsePage(),
      ),
    ),
    // GoRoute(
    //   path: "/favorites",
    //   pageBuilder: (context, state) => const MaterialPage(
    //     child: FavoritesPage(),
    //   ),
    // ),
    // GoRoute(
    //   path: "/profile",
    //   pageBuilder: (context, state) => const MaterialPage(
    //     child: ProfileScreen(),
    //   ),
    // ),
    GoRoute(
      path: "/about",
      pageBuilder: (context, state) => const MaterialPage(
        child: AboutPage(),
      ),
    ),
    // GoRoute(
    //   path: "/rolemgt",
    //   pageBuilder: (context, state) => const MaterialPage(
    //     child: RoleMgtScreen(),
    //   ),
    // ),
    GoRoute(
      path: "/loading",
      pageBuilder: (context, state) => const MaterialPage(
        child: LoadingScreen(),
      ),
    ),
  ],
);
