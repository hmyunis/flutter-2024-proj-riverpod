import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_riverpod/providers/avatar_provider.dart';

void main() {
  group('AuthNotifier', () {
    test('AvatarNotifier starts with initial state of 0', () {
      final notifier = AvatarNotifier();
      expect(notifier.state, 0);
    });

    test('setIndex updates the avatar index', () {
      final notifier = AvatarNotifier();
      notifier.setIndex(5);
      expect(notifier.state, 5);
    });

    test('reset sets the avatar index back to 0', () {
      final notifier = AvatarNotifier();
      notifier.setIndex(10);
      notifier.reset();
      expect(notifier.state, 0);
    });
  });
}
