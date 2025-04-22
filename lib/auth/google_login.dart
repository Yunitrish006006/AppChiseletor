import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:flutter/material.dart';

class GoogleLoginBlock extends StatelessWidget {
  const GoogleLoginBlock({
    super.key,
    required this.authManager,
    required this.onLoginStart,
    required this.onLoginEnd,
  });

  final AuthenticationManager authManager;
  final VoidCallback onLoginStart;
  final VoidCallback onLoginEnd;

  Future<void> _handleLogin(BuildContext context) async {
    onLoginStart();
    try {
      await authManager.signInWithGoogle();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.toString()}')),
        );
      }
    } finally {
      onLoginEnd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _handleLogin(context),
      icon: const Icon(Icons.g_mobiledata),
      label: const Text('Login with Google'),
    );
  }
}
