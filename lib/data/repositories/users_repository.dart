import 'dart:convert';

import '../../models/user.dart';

import '../services/users_api_service.dart';

class UsersRepository {
  final UsersApiService _usersApiService;
  UsersRepository(this._usersApiService);

  Future<User> getCurrentUser(String token) async {
    var user = await _usersApiService.getCurrentUser(token);
    user = jsonDecode(user);
    final userId = user['id'] as int;
    return await getUserById(userId);
  }

  Future<User> getUserById(int userId) async {
    final user = await _usersApiService.getUserById(userId.toString());
    return User.fromJson(jsonDecode(user));
  }

  Future<List<User>> getUsers() async {
    final response = await _usersApiService.getUsers();
    final users = jsonDecode(response);
    final allUsers = <User>[];
    for (final user in users) {
      allUsers.add(User.fromJson(user));
    }
    return allUsers;
  }

  Future<User> updateUser(User user, String? newPassword) async {
    final String updatedUser;
    if (newPassword == null || newPassword.trim() == '') {
      updatedUser = await _usersApiService.updateUser(user.id.toString(), {
        "username": user.username,
        "email": user.email,
      });
    } else {
      updatedUser = await _usersApiService.updateUser(user.id.toString(), {
        "username": user.username,
        "email": user.email,
        "password": newPassword,
      });
    }
    return User.fromJson(jsonDecode(updatedUser));
  }

  Future deleteUser(int userId) async {
    final user = await _usersApiService.deleteUser(userId.toString());
    return User.fromJson(jsonDecode(user));
  }

  Future<User> toggleAdmin(int userId, String token) async {
    final user = await _usersApiService.toggleAdmin(userId.toString(), token);
    return User.fromJson(jsonDecode(user));
  }
}
