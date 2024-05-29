import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';
import '../../providers/user_session_provider.dart';
import '../widgets/role_mgt_pannel.dart';

class RoleMgtScreen extends ConsumerWidget {
  const RoleMgtScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<User>> usersListProvider =
        ref.watch(userListProvider(ref.read(userSessionProvider).token!));
    return switch (usersListProvider) {
      AsyncData(:final value) => Scaffold(
          backgroundColor: Colors.blueGrey[700],
          appBar: AppBar(
            title: const Text('Role Management'),
            centerTitle: true,
            backgroundColor: Colors.blueGrey[900],
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Accounts",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RoleMgtPannel(users: value),
            ],
          ),
        ),
      AsyncError() => const Scaffold(
          body: Center(
            child: Text("Error, please try again"),
          ),
        ),
      _ => const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
    };
  }
}
