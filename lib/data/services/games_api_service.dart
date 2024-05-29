import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants.dart';

class GamesApiService {
  final _baseUrl = apiBaseUrl;

  Future getGames() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/games'));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future getGameById(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/games/$id'));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future getGamesByGenre(String genre) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/games?genre=$genre'));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future addGame(Map<String, dynamic> game, String token) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/games/new'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(game));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future updateGame(Map<String, dynamic> game, String token) async {
    try {
      final response =
          await http.patch(Uri.parse('$_baseUrl/games/${game['id']}'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(game));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteGame(String id, String token) async {
    try {
      final response =
          await http.delete(Uri.parse('$_baseUrl/games/$id'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
