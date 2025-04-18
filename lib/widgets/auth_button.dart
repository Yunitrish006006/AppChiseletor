import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_manager.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({super.key});

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationManager>(
      builder: (context, authManager, child) {
        return authManager.isLoggedIn
            ? ElevatedButton(
              onPressed: () {
                authManager.signOut();
              },
              child: const Text('Logout'),
            )
            : ElevatedButton(
              onPressed: () {
                _showLoginDialog(context, authManager);
              },
              child: const Text('Login'),
            );
      },
    );
  }

  void _showLoginDialog(
    BuildContext context,
    AuthenticationManager authManager,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Login'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _EmailLoginWidget(authManager: authManager),
              const SizedBox(height: 16),
              _GoogleLoginButton(authManager: authManager),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class _EmailLoginWidget extends StatelessWidget {
  final AuthenticationManager authManager;
  _EmailLoginWidget({required this.authManager});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            final email = emailController.text;
            final password = passwordController.text;
            authManager.signInWithEmailAndPassword(email, password);
            Navigator.pop(context);
          },
          child: const Text('Login with Email'),
        ),
      ],
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  final AuthenticationManager authManager;
  const _GoogleLoginButton({required this.authManager});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        authManager.signInWithGoogle();
        Navigator.pop(context);
      },
      child: const Text('Login with Google'),
    );
  }
}
