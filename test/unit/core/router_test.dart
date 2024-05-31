import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:video_game_catalogue_riverpod/presentation/screens/about_page.dart';
import 'package:video_game_catalogue_riverpod/presentation/screens/home_screen.dart';
import 'package:video_game_catalogue_riverpod/presentation/screens/loading_screen.dart';
import 'package:video_game_catalogue_riverpod/presentation/screens/login_page.dart';
import 'package:video_game_catalogue_riverpod/presentation/screens/registration_page.dart';
import 'package:video_game_catalogue_riverpod/presentation/screens/role_mgt_screen.dart';


GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      pageBuilder: (context, state) => const MaterialPage(
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: "/register",
      pageBuilder: (context, state) => const MaterialPage(
        child: RegistrationPage(),
      ),
    ),
    GoRoute(
      path: "/home",
      pageBuilder: (context, state) => const MaterialPage(
        child: HomeScreen(),
      ),
    ),
    GoRoute(
      path: "/about",
      pageBuilder: (context, state) => const MaterialPage(
        child: AboutPage(),
      ),
    ),
    GoRoute(
      path: "/rolemgt",
      pageBuilder: (context, state) => const MaterialPage(
        child: RoleMgtScreen(),
      ),
    ),
    GoRoute(
      path: "/loading",
      pageBuilder: (context, state) => const MaterialPage(
        child: LoadingScreen(),
      ),
    ),
  ],
);

void main() {
  group('App Router Test', () {
    test('App Router is created without errors', () {
      expect(appRouter, isA<GoRouter>());
    });
  });
}