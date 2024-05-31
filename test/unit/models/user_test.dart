import 'package:test/test.dart';
import 'package:video_game_catalogue_riverpod/models/user.dart';

void main() {
  group('User', () {
    test('should create a User with the given values', () {
      const id = 1;
      const username = 'moti';
      const email = 'moti@example.com';
      const joinDate = '2024-05-31';
      const role = 'admin';
      const token = 'sampleToken';

      final user = User(
        id: id,
        username: username,
        email: email,
        joinDate: joinDate,
        role: role,
        token: token,
      );

      expect(user.id, equals(id));
      expect(user.username, equals(username));
      expect(user.email, equals(email));
      expect(user.joinDate, equals(joinDate));
      expect(user.role, equals(role));
      expect(user.token, equals(token));
    });

    test('fromJson should return a valid User object', () {
      final json = {
        'id': 1,
        'username': 'testuser',
        'email': 'testuser@example.com',
        'joinDate': '2023-05-31',
        'role': 'admin',
        'token': 'sampleToken',
      };

      final user = User.fromJson(json);

      expect(user.id, equals(json['id']));
      expect(user.username, equals(json['username']));
      expect(user.email, equals(json['email']));
      expect(user.joinDate, equals(json['joinDate']));
      expect(user.role, equals(json['role']));
      expect(user.token, equals(json[null]));
    });

    test('toString should return a valid string representation', () {
      final user = User(
        id: 1,
        username: 'testuser',
        email: 'testuser@example.com',
        joinDate: '2023-05-31',
        role: 'admin',
        token: 'sampleToken',
      );

      final stringRepresentation = user.toString();

      expect(
        stringRepresentation,
        equals(
          'User(id: 1, username: testuser, email: testuser@example.com, joinDate: 2023-05-31, role: admin, token: sampleToken)',
        ),
      );
    });
  });
}
