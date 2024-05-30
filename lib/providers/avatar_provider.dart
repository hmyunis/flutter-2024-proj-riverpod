import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvatarNotifier extends StateNotifier<int> {
  AvatarNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }

  void reset() {
    state = 0;
  }
}

final avatarProvider = StateNotifierProvider<AvatarNotifier, int>((ref) {
  return AvatarNotifier();
});
