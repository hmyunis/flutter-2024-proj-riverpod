import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/users_repository.dart';
import '../data/services/users_api_service.dart';
import '../models/user.dart';
import 'user_session_provider.dart';

final userListProvider = AsyncNotifierProvider.autoDispose
    .family<UserNotifier, List<User>, String>(UserNotifier.new);

final currentUserProvider = FutureProvider.autoDispose((ref) async {
  return await ref
      .watch(userListProvider(ref.read(userSessionProvider).token!).notifier)
      .getCurrentUser();
});

class UserNotifier extends AutoDisposeFamilyAsyncNotifier<List<User>, String> {
  String token = "";

  @override
  Future<List<User>> build(String arg) async {
    token = arg;
    final UsersRepository usersRepository = UsersRepository(UsersApiService());
    return await usersRepository.getUsers();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<User> getCurrentUser() async {
    final UsersRepository usersRepository = UsersRepository(UsersApiService());
    return await usersRepository.getCurrentUser(token);
  }

  Future<void> promoteUser(int userId) async {
    final UsersRepository usersRepository = UsersRepository(UsersApiService());
    await usersRepository.toggleAdmin(userId, token);
    await refresh();
  }

  Future<void> demoteUser(int userId) async {
    final UsersRepository usersRepository = UsersRepository(UsersApiService());
    await usersRepository.toggleAdmin(userId, token);
    await refresh();
  }

  Future<void> updateUser(User user, String newPassword) async {
    final UsersRepository usersRepository = UsersRepository(UsersApiService());
    await usersRepository.updateUser(user, newPassword);
    await refresh();
  }

  Future<void> deleteUser(User user) async {
    final UsersRepository usersRepository = UsersRepository(UsersApiService());
    await usersRepository.deleteUser(user.id!);
    await refresh();
  }
}
