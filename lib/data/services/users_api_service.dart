import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants.dart';

class UsersApiService {
  final _baseUrl = apiBaseUrl;

  Future getCurrentUser(String token) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/users/whoami'), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final user = response.body;
        return user;
      }
    } catch (e) {
      e.toString();
    }
  }

  Future getUserById(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users/$id'));
      if (response.statusCode == 200) {
        final user = response.body;
        return user;
      }
    } catch (e) {
      e.toString();
    }
  }

  Future getUsers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users'));
      if (response.statusCode == 200) {
        final users = response.body;
        return users;
      }
    } catch (e) {
      e.toString();
    }
  }

  Future updateUser(String id, Map<String, dynamic> user) async {
    try {
      final response = await http.patch(Uri.parse('$_baseUrl/users/$id'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(user));
      if (response.statusCode == 200) {
        final updatedUser = response.body;
        return updatedUser;
      }
    } catch (e) {
      e.toString();
    }
  }

  Future deleteUser(String id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/users/$id'));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      e.toString();
    }
  }

  Future toggleAdmin(String id, String token) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/users/toggleadmin/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final updatedUser = response.body;
        return updatedUser;
      }
    } catch (e) {
      e.toString();
    }
  }
}
