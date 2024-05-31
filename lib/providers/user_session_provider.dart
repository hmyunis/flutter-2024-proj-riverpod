import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

class UserSessionNotifier extends StateNotifier<User> {
  UserSessionNotifier()
      : super(User(username: "", email: "", joinDate: "", role: ""));
  void setUser(User user) {
    state = user;
  }

  void clear() {
    state = User(username: "", email: "", joinDate: "", role: "");
  }
}

final userSessionProvider = StateNotifierProvider<UserSessionNotifier, User>(
    (ref) => UserSessionNotifier());
