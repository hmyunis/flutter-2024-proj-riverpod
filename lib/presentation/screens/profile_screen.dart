import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/avatars.dart';
import '../../models/user.dart';
import '../../providers/avatar_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/user_session_provider.dart';
import '../widgets/avatar_picker_dialog.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  int avatarIndex = 0;

  @override
  void initState() {
    super.initState();
    _usernameController.text = ref.read(userSessionProvider).username;
    _emailController.text = ref.read(userSessionProvider).email;
    _passwordController.text = "";
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.withOpacity(0.3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.blueGrey.withOpacity(0.7),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  String isValidEmail(email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be null or empty.';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      return 'Email address is not in the correct format.';
    }

    final emailParts = email.split('@');
    final username = emailParts[0];
    final domain = emailParts[1];

    bool isValidUsername(String username) {
      final usernameRegex = RegExp(r'^[\w\-]+$');
      return usernameRegex.hasMatch(username);
    }

    bool isValidDomain(String domain) {
      final domainRegex = RegExp(r'^[\w\-]+(\.[a-zA-Z]{2,4})+$');
      return domainRegex.hasMatch(domain);
    }

    if (username.isEmpty || !isValidUsername(username)) {
      return 'Username is not valid.';
    }

    if (domain.isEmpty || !isValidDomain(domain)) {
      return 'Domain is not valid.';
    }

    return 'true';
  }

  Future<void> _showUpdateConfirmationDialog() async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm update'),
          content: const Text(
              'Are you sure you want to overwrite all three account details with the new ones?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.blueGrey[200],
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (confirmed != null && confirmed) {
      final String username = _usernameController.text.trim();
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      if (username.isEmpty || password.isEmpty || email.isEmpty) {
        showErrorSnackBar("Please fill in all three fields.");
        return;
      }

      if (username.length < 4 || password.length < 8) {
        if (username.length < 4 && password.length >= 8) {
          showErrorSnackBar("Username must be at least 4 characters.");
        }
        if (username.length >= 4 && password.length < 8) {
          showErrorSnackBar("Password must be at least 8 characters.");
        }
        if (username.length < 4 && password.length < 8) {
          showErrorSnackBar("Username and password are too short.");
        }
        return;
      }

      if (isValidEmail(email) != 'true') {
        showErrorSnackBar(isValidEmail(email));
        return;
      }

      ref
          .read(userListProvider(ref.read(userSessionProvider).token!).notifier)
          .updateUser(
              User(
                id: ref.read(userSessionProvider).id,
                username: _usernameController.text,
                email: _emailController.text,
                joinDate: ref.read(userSessionProvider).joinDate,
                role: ref.read(userSessionProvider).role,
              ),
              _passwordController.text);
      ref.read(userSessionProvider.notifier).setUser(
            User(
              id: ref.read(userSessionProvider).id,
              username: _usernameController.text,
              email: _emailController.text,
              joinDate: ref.read(userSessionProvider).joinDate,
              role: ref.read(userSessionProvider).role,
              token: ref.read(userSessionProvider).token,
            ),
          );
      ref.invalidate(currentUserProvider);
      showSuccessSnackBar("Account updated successfully.");
    }
  }

  Future<void> _showDeleteConfirmationDialog() async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm termination'),
          content: const Text(
              'Are you sure you want to permanently delete your account?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.red[100],
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (confirmed != null && confirmed) {
      ref
          .read(userListProvider(ref.read(userSessionProvider).token!).notifier)
          .deleteUser(
            User(
              id: ref.read(userSessionProvider).id,
              username: _usernameController.text,
              email: _emailController.text,
              joinDate: ref.read(userSessionProvider).joinDate,
              role: ref.read(userSessionProvider).role,
            ),
          );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(
                child: Text(
                  'Account deleted successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.red.withOpacity(0.5),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      );
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<User> user = ref.watch(currentUserProvider);

    return switch (user) {
      AsyncData(:final value) => SingleChildScrollView(
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.blueGrey[900],
                elevation: 10,
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 2.0,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  avatars[ref.watch(avatarProvider)]),
                              radius: 50,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AvatarPickerDialog(),
                                );
                                showSuccessSnackBar(
                                    "Avatar saved successfully.");
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        value.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Join date: ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              Text(
                                value.joinDate,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _usernameController,
                            style: const TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: const Icon(Icons.person),
                              prefixIconColor: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: const Icon(Icons.email),
                              prefixIconColor: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              labelStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: const Icon(Icons.lock_outline),
                              prefixIconColor: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(height: 20),
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: _showDeleteConfirmationDialog,
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.red[700]),
                                ),
                                label: const Text('Terminate'),
                                icon: const Icon(Icons.dangerous_rounded),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                onPressed: _showUpdateConfirmationDialog,
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.blue[700]),
                                ),
                                label: const Text('Update'),
                                icon: const Icon(Icons.edit_rounded),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ref.read(userSessionProvider).role == "owner"
                  ? ElevatedButton.icon(
                      onPressed: () {
                        context.push('/rolemgt');
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.blueGrey),
                        padding:
                            WidgetStateProperty.all(const EdgeInsets.all(10.0)),
                      ),
                      label: const Text(
                        'Role configuration setting',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    )
                  : Container(),
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
