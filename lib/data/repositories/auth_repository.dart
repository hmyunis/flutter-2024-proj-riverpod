import 'dart:convert';

import '../services/auth_api_service.dart';

class AuthRepository {
  final AuthApiService _authApiService;

  AuthRepository(this._authApiService);

  Future<String> login(String username, String password) async {
    final jsonResponse = await _authApiService.signin(username, password);
    return jsonDecode(jsonResponse);
  }

  Future<String> register(String username, String email, String password, String confirmPassword) async {
    final jsonResponse = await _authApiService.signup(username, email, password, confirmPassword);
    return jsonDecode(jsonResponse);
  }

  Future<void> logout() async {
    await _authApiService.logout();
  }

  String? get token => _authApiService.token;
}
