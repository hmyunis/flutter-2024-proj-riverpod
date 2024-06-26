import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showErrorSnackbar(String message) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login-bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(218, 69, 90, 100),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    key: const Key("login_username"),
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: Colors.blueGrey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    key: const Key("login_password"),
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.lock_outline),
                      prefixIconColor: Colors.blueGrey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    key: const Key("Login_button"),
                    onPressed: () {
                      // Input Validation
                      final String username = _usernameController.text.trim();
                      final String password = _passwordController.text.trim();

                      if (username.isEmpty || password.isEmpty) {
                        if (username.isEmpty && password.isNotEmpty) {
                          showErrorSnackbar("Username cannot be empty.");
                        }
                        if (password.isEmpty && username.isNotEmpty) {
                          showErrorSnackbar("Password cannot be empty.");
                        }
                        if (username.isEmpty && password.isEmpty) {
                          showErrorSnackbar(
                              "Please fill in all of the fields.");
                        }
                        return;
                      }

                      if (username.length < 4 || password.length < 8) {
                        if (username.length < 4 && password.length >= 8) {
                          showErrorSnackbar(
                              "Username must be at least 4 characters.");
                        }
                        if (username.length >= 4 && password.length < 8) {
                          showErrorSnackbar(
                              "Password must be at least 8 characters.");
                        }
                        if (username.length < 4 && password.length < 8) {
                          showErrorSnackbar(
                              "Username and password are too short.");
                        }
                        return;
                      }

                      ref.read(authProvider.notifier).login(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          );
                      context.go('/loading');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[500],
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      TextButton(
                        key: const Key("signup button"),
                        onPressed: () {
                          context.go('/register');
                        },
                        child: Text(
                          'Create an account',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.blueGrey[200],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
