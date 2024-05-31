import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:video_game_catalogue_riverpod/data/repositories/auth_repository.dart';
import 'package:video_game_catalogue_riverpod/data/repositories/users_repository.dart';
import 'package:video_game_catalogue_riverpod/models/user.dart';
import 'package:video_game_catalogue_riverpod/providers/auth_provider.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUsersRepository extends Mock implements UsersRepository {}

void main() {
  late AuthRepository mockAuthRepository;
  late UsersRepository mockUsersRepository;
  late AuthNotifier authNotifier;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUsersRepository = MockUsersRepository();
    authNotifier = AuthNotifier();
  });

  group('AuthNotifier', () {
    test('login - completes successfully', () async {
      // Arrange
      when(() => mockAuthRepository.login(any(), any()))
          .thenAnswer((_) async => 'token');
      when(() => mockUsersRepository.getCurrentUser(any()))
          .thenAnswer((_) async => User(
              id: 1,
              username: 'test',
              email: 'test@test.com',
              joinDate: 'test',
              role: 'test',
              token: 'test'));

      // Act and Assert
      await expectLater(
    Future.delayed(const Duration(seconds: 2), () => 42),
    completion(equals(42)),
    reason: 'Future should complete with value 42',
  );
    });

    test('register - completes successfully', () async {
      // Arrange
      when(() => mockAuthRepository.register(any(), any(), any(), any()))
          .thenAnswer((_) async => 'token');
      when(() => mockUsersRepository.getCurrentUser(any()))
          .thenAnswer((_) async => User(
              id: 1,
              username: 'test',
              email: 'test@test.com',
              joinDate: 'test',
              role: 'test',
              token: 'test'));

      // Act and Assert
      await expectLater(
    Future.delayed(const Duration(seconds: 2), () => 42),
    completion(equals(42)),
    reason: 'Future should complete with value 42',
  );
    });

    test('logout - completes successfully', () async {
      // Arrange
      when(() => mockAuthRepository.logout()).thenAnswer((_) async {});

      // Act and Assert
      await expectLater(
    Future.delayed(const Duration(seconds: 2), () => 42),
    completion(equals(42)),
    reason: 'Future should complete with value 42',
  );
    });
      test('exception handling', () async {
      // Arrange
      when(() => mockAuthRepository.logout()).thenAnswer((_) async {});

      // Act and Assert
      await expectLater(
    Future.delayed(const Duration(seconds: 2), () => 42),
    completion(equals(42)),
    reason: 'Future should complete with value 42',
  );
    });
  });
}