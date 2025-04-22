import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:flutter/material.dart';

class GoogleLoginBlock extends StatelessWidget {
  GoogleLoginBlock({super.key, required this.authManager});
  final AuthenticationManager authManager;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        authManager.signInWithGoogle();
        if (Navigator.canPop(context)) Navigator.pop(context);
      },
      child: const Text('Login with Google'),
    );
  }
}
