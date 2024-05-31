import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/register-bg.jpg',
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
                        'Register',
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
                    
                    key: const Key("username_field"),
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
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    key: const Key("email_field"),
                    controller: _emailController,
                    style: const TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.email_rounded),
                      prefixIconColor: Colors.blueGrey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    key: const Key("password_field"),
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.lock_open_outlined),
                      prefixIconColor: Colors.blueGrey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    key: const Key("confirm_password_field"),
                    controller: _confirmPasswordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
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
                    key: const Key("create_account_field"),
                    onPressed: () {
                      // Input Validation
                      final String username = _usernameController.text.trim();
                      final String email = _emailController.text.trim();
                      final String password = _passwordController.text.trim();
                      final String confirmPassword =
                          _confirmPasswordController.text.trim();

                      if (username.isEmpty ||
                          password.isEmpty ||
                          email.isEmpty ||
                          confirmPassword.isEmpty) {
                        showErrorSnackbar("Please fill in all of the fields.");
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

                      if (isValidEmail(email) != 'true') {
                        showErrorSnackbar(isValidEmail(email));
                        return;
                      }

                      if (password != confirmPassword) {
                        showErrorSnackbar("Passwords do not match.");
                        return;
                      }

                      ref.read(authProvider.notifier).register(
                            username: _usernameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
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
                    child: const Text('Create Account'),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Row(
                      children: [
                        TextButton(
                          key: const Key("login_field"),
                          onPressed: () {
                            context.go('/');
                          },
                          child: Text(
                            'Log in',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.blueGrey[200],
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
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
