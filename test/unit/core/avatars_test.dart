import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Avatars List', () {
    test('should contain the correct number of avatar paths', () {
      final List<String> avatars = [
        "assets/images/avatars/001.jpg",
        "assets/images/avatars/002.jpg",
        "assets/images/avatars/003.jpg",
        "assets/images/avatars/004.jpg",
        "assets/images/avatars/005.jpg",
        "assets/images/avatars/006.jpg",
        "assets/images/avatars/007.jpg",
        "assets/images/avatars/008.jpg",
        "assets/images/avatars/009.jpg",
        "assets/images/avatars/010.jpg",
        "assets/images/avatars/011.jpg",
        "assets/images/avatars/012.jpg",
        "assets/images/avatars/013.jpg",
        "assets/images/avatars/014.jpg",
        "assets/images/avatars/015.jpg",
        "assets/images/avatars/016.jpg",
        "assets/images/avatars/017.jpg",
        "assets/images/avatars/018.jpg",
      ];

      // Verify the length of the list
      expect(avatars.length, equals(18));
    });

    test('should contain avatar paths in the correct format', () {
      final List<String> avatars = [
        "assets/images/avatars/001.jpg",
        "assets/images/avatars/002.jpg",
        "assets/images/avatars/003.jpg",
        "assets/images/avatars/004.jpg",
        "assets/images/avatars/005.jpg",
        "assets/images/avatars/006.jpg",
        "assets/images/avatars/007.jpg",
        "assets/images/avatars/008.jpg",
        "assets/images/avatars/009.jpg",
        "assets/images/avatars/010.jpg",
        "assets/images/avatars/011.jpg",
        "assets/images/avatars/012.jpg",
        "assets/images/avatars/013.jpg",
        "assets/images/avatars/014.jpg",
        "assets/images/avatars/015.jpg",
        "assets/images/avatars/016.jpg",
        "assets/images/avatars/017.jpg",
        "assets/images/avatars/018.jpg",
      ];

      // Verify the format of each avatar path
      for (var i = 0; i < avatars.length; i++) {
        final index = (i + 1).toString().padLeft(3, '0');
        expect(avatars[i], equals('assets/images/avatars/$index.jpg'));
      }
    });
  });
}
