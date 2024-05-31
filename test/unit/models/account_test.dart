import 'package:test/test.dart';
import 'package:video_game_catalogue_riverpod/models/account.dart';

void main() {
  group('Account', () {
    test('should create an account with the given userName and userType', () {
      const userName = 'Moti';
      const userType = 'admin';

      const account = Account(userName: userName, userType: userType);

      expect(account.userName, equals(userName));
      expect(account.userType, equals(userType));
    });
  });
}
