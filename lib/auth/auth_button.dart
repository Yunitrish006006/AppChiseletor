import 'package:app_chiseletor/auth/email_login.dart';
import 'package:app_chiseletor/auth/google_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_manager.dart';

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
              EmailLoginBlock(authManager: authManager),
              const SizedBox(height: 16),
              GoogleLoginBlock(authManager: authManager),
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
