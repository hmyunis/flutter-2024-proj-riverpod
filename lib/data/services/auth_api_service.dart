import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants.dart';

class AuthApiService {
  String? _token;
  final String _baseUrl = apiBaseUrl;

  Future<String> signin(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signin'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      _token = response.body;
      return _token!;
    } else {
      throw Exception('Invalid credentials: Login failed');
    }
  }

  Future<String> signup(String username, String email, String password,
      String confirmPassword) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final token = response.body;
      _token = token;
      return token;
    } else {
      throw Exception('Registration failed. Try again.');
    }
  }

  Future<void> logout() async {
    _token = null;
    await http.post(
      Uri.parse('$_baseUrl/signout'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }

  String? get token => _token;
}
